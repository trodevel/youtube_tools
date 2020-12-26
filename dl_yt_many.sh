#!/bin/bash

LINKS=$1
FOLDER=$2

[[ -z $LINKS ]] && echo "ERROR: links is not given" && exit
[[ -z $FOLDER ]] && echo "ERROR: folder is not given" && exit

i=1;
links=$( cat $LINKS | sed "s/&link.*//" );

pids=""

ytdl()
{
    local NUM=$1
    local LINK=$2
    local DATUM=$3
    local outp="/tmp/ytdl_${DATUM}_${NUM}_${RANDOM}.txt"

    echo "starting download $NUM"

    ytdl.sh $LINK >$outp

    rm $outp

    echo "finished download $NUM"
}

DATUM=$(date -u +%Y%m%d_%H%M%S)

CURDIR=$( pwd )

cd $FOLDER

for s in $links;
do
    ytdl $i $s "$DATUM" &

    pid=$!

    pids="$pids $pid"

    ((i++))

done;

echo "waiting for pids $pids"

wait $pids

cd $CURDIR
