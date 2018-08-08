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
#mv *.jpg ../pics

echo "what's the title?"
read TITLE

echo "what tags?"
read TAGS

echo "tell me bout it"
read DETAILS

echo "time spent? format: 1.25"
read TIME

echo "---" > post.tmp
echo "layout: post" >> post.tmp
echo "title: \"$TITLE\"" >> post.tmp
echo "date: $DATE" >> post.tmp
echo "tags: $TAGS" >> post.tmp
echo '---' >> post.tmp
echo "" >> post.tmp
echo "$DETAILS" >> post.tmp
echo "" >> post.tmp
echo "Pics!" >> post.tmp
echo "" >> post.tmp
FILEPOST=1
until [ $FILECOUNT -eq $FILEPOST ]
do
	echo -n '![alt text](https://rv8bebo.com/pics/' >> post.tmp
	echo -n $DATE.$FILEPOST >> post.tmp
	echo -n '.jpg "Image ' >> post.tmp
	echo -n $FILEPOST >> post.tmp
	echo -n '"){:height="25%" width="25%""}' >> post.tmp
	echo "" >> post.tmp
	FILEPOST=$(($FILEPOST+1))
done
echo "" >> post.tmp
echo "" >> post.tmp
echo "Time Spent: $TIME" >> post.tmp

TITLE=$(sed 's/ /-/g' <<< "$TITLE")
cp post.tmp ../_posts/$DATE-$TITLE.md


rm -rf ~/repos/bebo-rv8/tmp

