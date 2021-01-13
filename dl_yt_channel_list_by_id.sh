#!/bin/bash

ID=$1
NAME=$2
DATE=$3

[[ -z $ID ]] && echo "ERROR: ID is not given" && exit
[[ -z $NAME ]] && echo "ERROR: NAME is not given" && exit

DATUM=$(date -u +%Y%m%d)

[[ -n $DATE ]] && PAR="--dateafter $DATE"

LIST_NAME=channel_${NAME}_${DATUM}.txt

youtube-dl -j --flat-playlist $PAR "https://www.youtube.com/channel/$ID/videos"  | jq -r '.id' | sed 's_^_https://youtu.be/_' | tac > $LIST_NAME

echo -n "number of videos : "

cat $LIST_NAME | wc -l
