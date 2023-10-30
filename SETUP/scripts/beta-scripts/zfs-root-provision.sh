#!/bin/sh
set -e

POOL_ARGS=$@

# Pool building
zpool create -m legacy root $POOL_ARGS
zfs set compression=lz4 root
zfs set xattr=sa root
zfs set atime=off root
mkdir -p /mnt
mount -t zfs root /mnt

zfs create root/conf
zfs set setuid=off root/conf
zfs set devices=off root/conf
mkdir -p /mnt/conf
mount -t zfs {root,/mnt}/conf
mkdir -p /mnt/{conf,etc}/nixos
mount -o defaults,bind /mnt/{conf,etc}/nixos

zfs create root/log
zfs set setuid=off root/log
zfs set devices=off root/log
mkdir -p /mnt/var/log
mount -t zfs {root,/mnt/var}/log

zfs create root/state
zfs set setuid=off root/state
zfs set devices=off root/state
mkdir -p /mnt/state
mount -t zfs {root,/mnt}/state
mkdir -p /mnt/{state/{lib,home/root},var/{lib,db},home}
mount -o defaults,bind /mnt/state/lib /mnt/var/lib
mount -o defaults,bind /mnt/state/lib /mnt/var/db
mount -o defaults,bind /mnt/state/home /mnt/home
mount -o defaults,bind /mnt/state/home/root /mnt/root

zfs create root/tmp
zfs set sync=disabled root/tmp
zfs set setuid=off root/tmp
zfs set devices=off root/tmp
mkdir -p /mnt/tmp
mount -t zfs root/tmp /mnt/tmp
chmod 1777 /mnt/tmp