#!/bin/bash

URL=$1

[[ -z "$URL" ]] && echo "USAGE: $0 <URL>" && exit

youtube-dl -x --embed-thumbnail --audio-format mp3 --add-metadata --audio-quality 0 $URL
