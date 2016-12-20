#!/bin/bash

sgdisk \
  -n 1:0:+4M -t 1:8300 -c 1:"bios" \
  -n 1:4M:+128M -t 1:8300 -c 1:"boot" \
  -n 2:-4G:+4G   -t 2:8200 -c 2:"swap" \
  -n 3:0     -t 3:8300 -c 3:"root" \
  -p /dev/sda

sync

mkfs.vfat /dev/sda2
mkfs.ext4 /dev/sda4

mkswap /dev/sda3 && swapon /dev/sda3
