#!/bin/bash

sgdisk \
  -n 1:0:+2M     -t 1:ef02 -c 1:"grub" \
  -n 2:+2M:+128M -t 2:8300 -c 2:"boot" \
  -n 3:-4G+4G    -t 3:8200 -c 3:"swap" \
  -n 4:+128M:-4G -t 4:8300 -c 4:"root" \
  -p /dev/sda

sync
fdisk -l /dev/sda
mkfs.ext2 /dev/sda2
mkfs.ext4 /dev/sda4

mkswap /dev/sda3 && swapon /dev/sda3
