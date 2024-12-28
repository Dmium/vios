#!/bin/sh
set -e

./in-cc.sh /bin/bash -C ./clean.sh
./in-cc.sh /bin/bash -C ./iso.sh

mkdir isos
mv vios.iso isos/vios.iso
