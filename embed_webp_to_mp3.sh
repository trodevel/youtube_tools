#!/bin/bash

# A tool is work-around for youtube-dl bug #25687
# https://github.com/ytdl-org/youtube-dl/issues/25687

MP3=$1
PIC=$2

[[ -z "$MP3" ]] && echo "ERROR: MP3 is not defined" && exit
[[ -z "$PIC" ]] && echo "ERROR: PIC is not defined" && exit

echo "MP3 = $MP3"
echo "PIC = $PIC"

[[ ! -f "$MP3" ]] && echo "ERROR: file $MP3 not found" && exit
[[ ! -f "$PIC" ]] && echo "ERROR: file $PIC not found" && exit

JPEG=$PIC.$RANDOM.jpg
PREV=$MP3.prev.mp3

echo "DEBUG: JPEG = $JPEG"
echo "DEBUG: PREV = $PREV"

ffmpeg -i "$PIC" "$JPEG"

mv "$MP3" "$PREV"

ffmpeg -i "$PREV" -i "$JPEG" -map 0:0 -map 1:0 -codec copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" "$MP3"

rm "$JPEG"
