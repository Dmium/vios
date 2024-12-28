#!/bin/sh
set -e

rm -rf isos
./in-cc.sh /bin/bash -C ./clean.sh
./in-cc.sh /bin/bash -C ./iso.sh

mkdir isos
mv vios.iso isos/vios.iso
./in-cc.sh /bin/bash -C ./clean.sh
