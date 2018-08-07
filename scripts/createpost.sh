#!/bin/bash
#Set working directory
cd ~/repos/bebo-rv8/

#Sync all new images and rename to date.
mkdir tmp
cd tmp
gdrive download -r 1h4zaiGGd-E3YC8246RdFcsGv6FViswR3
FILECOUNT=1
DATE=`date +%F`
for file in Rv8/*.jpg; do
	mv $file $DATE.$FILECOUNT.jpg
	FILECOUNT=$(($FILECOUNT+1))
done
mv *.jpg ../pics
rm -rf ~/repos/bebo-rv8/tmp
