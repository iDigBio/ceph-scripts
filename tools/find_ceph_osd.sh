#!/bin/bash

# utility script to find a ceph osd, given only the node name and drive name
# first, tell me which drive you want to find
if [ -z $1 ]; then echo "Please call this with the drive you are interested in, e.g., sda"; exit 1; else echo "Using drive '$1'"; fi
# let's get the FSID
osd_uuid=`lsblk -o NAME /dev/sdf | sed -e 's/--/-/g' | cut -d'-' -f9-13 | sed -e 's/NAME//g' | sed -e 's/sdf//g'`
echo "Your OSD FSID is:"
echo $osd_uuid
# find the corresponding osd
for i in `df -h | egrep -o ceph-[0-9]+ | cut -d- -f2`; do ceph osd find $i | grep -C5 $osd_uuid; done
