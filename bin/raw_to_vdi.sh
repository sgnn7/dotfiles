#!/bin/bash -e

if [ $# -gt 2 ] ||
   [ $# -lt 1 ]; then
  echo "Usage: $0 gz_raw_image [<vdi_size_in_gb>]"
  exit 1
fi

COMPRESSED_IMAGE="$1"

# Size in GB
VDI_SIZE=16
if [ $# -gt 1 ]; then
  VDI_SIZE="$2"
fi

IMAGE_NAME="${COMPRESSED_IMAGE%.img.gz}"

echo "Image name: ${IMAGE_NAME}"
echo "Using VDI size of ${VDI_SIZE} GB"

echo "- Decompressing $IMAGE_NAME..."
if [ ! -f "${IMAGE_NAME}.img" ]; then
  gunzip -k "$COMPRESSED_IMAGE"
fi

echo "- Converting $IMAGE_NAME to VDI..."
# Assume that the compressed image is a '*.img'
if [ ! -f "${IMAGE_NAME}.vdi" ]; then
  vboxmanage convertdd "$IMAGE_NAME.img" "$IMAGE_NAME.vdi" --format VDI
fi

rm -f "${IMAGE_NAME}.img"

echo "- Expanding $IMAGE_NAME to $VDI_SIZE GB..."
vboxmanage modifyhd "$IMAGE_NAME.vdi" --resize "$(( $VDI_SIZE * 1024 ))"

echo "- Randomizing UUID..."
vboxmanage internalcommands sethduuid "${IMAGE_NAME}.vdi"

echo "OK!"
