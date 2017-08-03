#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
cat > /etc/inittab <<'DATA'
#
# /etc/inittab:  This file describes how the INIT process should set up
#                the system in a certain run-level.
#
# Author:  Miquel van Smoorenburg, <miquels@cistron.nl>
# Modified by:  Patrick J. Volkerding, <volkerdi@ftp.cdrom.com>
# Modified by:  Daniel Robbins, <drobbins@gentoo.org>
# Modified by:  Martin Schlemmer, <azarah@gentoo.org>
# Modified by:  Mike Frysinger, <vapier@gentoo.org>
# Modified by:  Robin H. Johnson, <robbat2@gentoo.org>
# Modified by:  William Hubbs, <williamh@gentoo.org>
#
# $Id$

# Default runlevel.
id:3:initdefault:

# System initialization, mount local filesystems, etc.
si::sysinit:/sbin/openrc sysinit

# Further system initialization, brings up the boot runlevel.
rc::bootwait:/sbin/openrc boot

l0:0:wait:/sbin/openrc shutdown 
l0s:0:wait:/sbin/halt -dhnp
l1:1:wait:/sbin/openrc single
l2:2:wait:/sbin/openrc nonetwork
l3:3:wait:/sbin/openrc default
l4:4:wait:/sbin/openrc default
l5:5:wait:/sbin/openrc default
l6:6:wait:/sbin/openrc reboot
l6r:6:wait:/sbin/reboot -dkn
#z6:6:respawn:/sbin/sulogin

# new-style single-user
su0:S:wait:/sbin/openrc single
su1:S:wait:/sbin/sulogin

# TERMINALS
c1:12345:respawn:/sbin/mingetty --autologin root --noclear tty1
c2:12345:respawn:/sbin/mingetty --autologin root --noclear tty2
c3:12345:respawn:/sbin/mingetty --autologin root --noclear tty3
c4:12345:respawn:/sbin/mingetty --autologin root --noclear tty4
c5:12345:respawn:/sbin/mingetty --autologin root --noclear tty5
c6:12345:respawn:/sbin/mingetty --autologin root --noclear tty6

# SERIAL CONSOLES
#s0:12345:respawn:/sbin/agetty -L 115200 ttyS0 vt100
#s1:12345:respawn:/sbin/agetty -L 115200 ttyS1 vt100

# What to do at the "Three Finger Salute".
ca:12345:ctrlaltdel:/sbin/shutdown -r now

# Used by /etc/init.d/xdm to control DM startup.
# Read the comments in /etc/init.d/xdm for more
# info. Do NOT remove, as this will start nothing
# extra at boot if /etc/init.d/xdm is not added
# to the "default" runlevel.
x:a:once:/etc/X11/startDM.sh
DATA
EOF
