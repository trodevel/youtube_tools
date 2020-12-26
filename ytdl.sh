#!/bin/bash

URL=$1
PREF=$2

[[ -z "$URL" ]] && echo "USAGE: $0 <URL> [<PREF>]" && exit

if [[ -z "$PREF" ]]
then
    youtube-dl -x --embed-thumbnail --audio-format mp3 --add-metadata --audio-quality 0 $URL
else
    youtube-dl -x --embed-thumbnail --audio-format mp3 --add-metadata --audio-quality 0 -o "$PREF - %(title)s.%(ext)s" $URL
fi
