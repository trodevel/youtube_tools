#!/bin/bash

NAME=$1
LIST_NAME=$2

[[ -z $NAME ]] && echo "ERROR: NAME is not given" && exit

DATUM=$(date -u +%Y%m%d)

[[ -z $LIST_NAME ]] && LIST_NAME=channel_${NAME}_${DATUM}.txt

youtube-dl -j --flat-playlist "https://www.youtube.com/user/$NAME/videos"  | jq -r '.id' | sed 's_^_https://youtu.be/_' | tac > $LIST_NAME

echo -n "number of videos : "

cat $LIST_NAME | wc -l
