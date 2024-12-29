#!/bin/sh
set -e
. ./config.sh

qemu-system-$(./target-triplet-to-arch.sh $HOST) -serial stdio -cdrom isos/vios.iso
