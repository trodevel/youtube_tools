#!/bin/bash

NAME=$1
DATE=$2

[[ -z $NAME ]] && echo "ERROR: NAME is not given" && exit

DATUM=$(date -u +%Y%m%d)

[[ -n $DATE ]] && PAR="--dateafter $DATE"

youtube-dl -j --flat-playlist $PAR "https://www.youtube.com/c/$NAME/videos"  | jq -r '.id' | sed 's_^_https://youtu.be/_' > channel_${NAME}_${DATUM}.txt
