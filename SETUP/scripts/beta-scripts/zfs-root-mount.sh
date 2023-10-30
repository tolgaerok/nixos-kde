#!/bin/sh
set -e

mount -t zfs root /mnt
mount -t zfs {root,/mnt}/conf
mount -o defaults,bind /mnt/{conf,etc}/nixos
mount -t zfs {root,/mnt/var}/log
mount -t zfs {root,/mnt}/state
mount -o defaults,bind /mnt/state/lib /mnt/var/lib
mount -o defaults,bind /mnt/state/lib /mnt/var/db
mount -o defaults,bind /mnt/state/home /mnt/home
mount -o defaults,bind /mnt/state/home/root /mnt/root
mount -t zfs root/tmp /mnt/tmp
