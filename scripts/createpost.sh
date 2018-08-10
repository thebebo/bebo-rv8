#!/bin/bash
#Set working directory
cd ~/repos/bebo-rv8/

#Sync all new images and rename to date.
cd tmp
gdrive download -r 1h4zaiGGd-E3YC8246RdFcsGv6FViswR3
cd ..

FILECOUNT=1
DATE=`date +%F`
for FILE in tmp/Rv8/*.jpg; do
	mv $FILE pics/$DATE.$FILECOUNT.jpg
	FILECOUNT=$(($FILECOUNT+1))
done

echo "what's the title?"
read TITLE

echo "what tags?"
read TAGS

echo "tell me bout it"
read DETAILS

echo "time spent? format: 1.25"
read TIME

echo "---" > tmp/post.tmp
echo "layout: post" >> tmp/post.tmp
echo "title: \"$TITLE\"" >> tmp/post.tmp
echo "date: $DATE" >> tmp/post.tmp
echo "tags: $TAGS" >> tmp/post.tmp
echo '---' >> tmp/post.tmp
echo "" >> tmp/post.tmp
echo "$DETAILS" >> tmp/post.tmp
echo "" >> tmp/post.tmp
echo "Pics!" >> tmp/post.tmp
echo "" >> tmp/post.tmp
FILEPOST=1
until [ $FILECOUNT -eq $FILEPOST ]
do
	echo -n '![alt text](https://rv8bebo.com/pics/' >> tmp/post.tmp
	echo -n $DATE.$FILEPOST >> tmp/post.tmp
	echo -n '.jpg "Image ' >> tmp/post.tmp
	echo -n $FILEPOST >> tmp/post.tmp
	echo -n '"){:height="25%" width="25%""}' >> tmp/post.tmp
	echo "" >> tmp/post.tmp
	FILEPOST=$(($FILEPOST+1))
done
echo "" >> tmp/post.tmp
echo "" >> tmp/post.tmp
echo "Time Spent: $TIME" >> tmp/post.tmp

TITLE=$(sed 's/ /-/g' <<< "$TITLE")
cp tmp/post.tmp _posts/$DATE-$TITLE.md

scripts/calculatetime.sh > _includes/time.html

git status && git add * && git commit -m "Blog Update" && git push
