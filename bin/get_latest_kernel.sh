#!/bin/bash -e

CURRENT_DIR=$(pwd)
BASE_URI="http://kernel.ubuntu.com/~kernel-ppa/mainline"
FINGERPRINT="60AA 7B6F 3043 4AE6 8E56  9963 E50C 6A09 17C6 22B0"
ARCH=$(dpkg --print-architecture)

declare -A FILES=([sources]="SOURCES" \
                  [commit]="COMMIT" \
                  [linux-image]="linux-image- generic_ ${ARCH}" \
                  [linux-headers]="linux-headers- generic_ ${ARCH}" \
                  [linux-headers-all]="linux-headers- _all\.deb" \
                 )

echo "Grabbing the GPG key"
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys "${FINGERPRINT}"

echo "Getting the version page..."
kernel_versions=$(curl -sL "${BASE_URI}" | sed -e 's/.*<a href="\([^\/"]*\).*/\1/g' | grep '^v')

echo "Sorting the versions..."
# Yeah, sort might not have `-V` :(
sorted_versions=$(echo "${kernel_versions}" | sort -rV)
highest_version=$(echo "${sorted_versions}" | sed -n '1p')

version_uri="${BASE_URI}/${highest_version}/"

echo "Version: ${highest_version}"

# XXX: dpkg versions have a build time prefix so we con't do this easily
#if [[ "$(dpkg -l | grep linux-image | awk '{print $3}' | grep "${highest_version##v}")" ]]; then
#  echo "Version ${highest_version} already installed. Skipping"
#  exit 1
#fi

verify_checksum() {
  filename="${1}"
  sha_sum=$(sha256sum $filename | awk '{print $1}')
  if ! grep "^${sha_sum}.*${filename}$" CHECKSUMS >/dev/null; then
    echo "Failed to verify ${filename}!"
    exit 1
  fi

  echo "${filename}: Checksum OK!"
}

echo "Getting the version page..."
version_page=$(curl -sL "${version_uri}")

echo "Making the directory..."
target_dir="${CURRENT_DIR}/${highest_version##v}"
mkdir -p "${target_dir}"
echo "Directory $target_dir made"

pushd "${target_dir}" >/dev/null
  echo "Checking CHECKSUM signature..."
  wget -qN "${version_uri}/CHECKSUMS"
  wget -qN "${version_uri}/CHECKSUMS.gpg"

  if ! gpg --batch --verify CHECKSUMS.gpg CHECKSUMS &>/dev/null; then
    echo "ERROR! Failure to verify checksum signature!"
    exit 1
  fi

  echo "Checking CHECKSUM signer..."
  if [[ -z "$(gpg --batch --verify CHECKSUMS.gpg CHECKSUMS 2>&1 | grep "${FINGERPRINT}")" ]]; then
    echo "ERROR! Failure to verify signer!"
    exit 1
  fi

  for filters in "${FILES[@]}"; do
    # echo "Filters: $filters"
    package_line="${version_page}"
    for filter in ${filters}; do
      package_line=$(echo "${package_line}" | grep "${filter}")
    done

    package_name=$(echo "${package_line}" | sed -n '1p' | sed -e 's/.*<a href="\([^"]*\).*/\1/')
    # echo "Downloading ${package_name}"
    wget -q --show-progress "${version_uri}/${package_name}" -O "${package_name}"

    # SOURCES isn't included in checksums
    if [ "${package_name}" == "SOURCES" ]; then
      continue
    fi

    verify_checksum "${package_name}"
  done

  echo "Downloading patches..."
  for patch in $(cat SOURCES | grep "^.*\.patch$"); do
    # echo "Downloading ${patch}"
    wget -q --show-progress "${version_uri}/${patch}" -O "${patch}"

    verify_checksum "${patch}"
  done

  echo
  echo "=== SUCCESS ==="
popd >/dev/null
