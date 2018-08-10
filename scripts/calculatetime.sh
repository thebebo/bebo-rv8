#!/bin/bash

cd ~/repos/bebo-rv8/
#By tag
TIMESUM=0
echo '<ul style="list-style-type:none">'
for TAGFILE in tag/*.md; do
	TAG=$(cat $TAGFILE | grep "tag: " | awk '{print $2}')
	for FILE in _posts/*.md; do
		grep -q $TAG $FILE
		if [ $? -eq 0 ]; then
			TIME=$(cat $FILE | grep "Time Spent: " | awk '{print $3}')
			TIMESUM=$(echo "$TIME + $TIMESUM" | bc -l)
		fi
	done
	        echo "	<li>$TAG Total: $TIMESUM</li>"
done

echo "	<li>--</li>"

#Total Time Spent
TIMESUM=0
for FILE in _posts/*.md; do
        TIME=$(cat $FILE | grep "Time Spent: " | awk '{print $3}')
        TIMESUM=$(echo "$TIME + $TIMESUM" | bc -l)
done
echo "	<li>Total to Date: $TIMESUM</li>"
echo '</ul>'
