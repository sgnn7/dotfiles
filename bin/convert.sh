#!/bin/bash

TARGET_DIRS="/usr/lib/eos-shell /usr/local/lib/eos-shell"

for target_dir in $TARGET_DIRS; do
  for lib in src/.libs/*.so; do
    echo "Linking $lib"
    lib_name=$(basename $lib)
    if [[ ! -L $target_dir/$lib_name ]]; then
      cp $target_dir/$lib_name $target_dir/$lib_name.bak
    fi

    ln -fs $(pwd)/$lib $target_dir/$lib_name
  done

  for typelib in src/*.typelib; do
    echo "Linking $typelib"
    typelib_name=$(basename $typelib)
    if [[ ! -L $target_dir/$typelib_name ]]; then
      cp $target_dir/$typelib_name $target_dir/$typelib_name.bak
    fi

    ln -fs $(pwd)/$typelib $target_dir/$typelib_name
  done
done

GIR_DIR=/usr/share/gir-1.0
for typelib in src/*.gir; do
  echo "Linking GIR $typelib"
  typelib_name=$(basename $typelib)
  if [[ -e $GIR_DIR/$typelib_name && ! -L $GIR_DIR/$typelib_name ]]; then
    cp $GIR_DIR/$typelib_name $GIR_DIR/$typelib_name.bak
  fi

  ln -fs $(pwd)/$typelib $GIR_DIR/$typelib_name
done
