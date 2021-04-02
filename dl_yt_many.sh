#!/bin/bash

LINKS=$1
FOLDER=$2

[[ -z $LINKS ]] && echo "ERROR: links is not given" && exit
[[ -z $FOLDER ]] && echo "ERROR: folder is not given" && exit

links=$( cat $LINKS | sed "s/&link.*//" );

num_links=$( echo $links | wc -w )

echo "INFO: number of links to download - $num_links"

pids=""

MAX_NUM_RETRIES=3

ytdl_core()
{
    local NUM=$1
    local LINK=$2
    local DATUM=$3
    local outp="/tmp/ytdl_${DATUM}_${NUM}_${RANDOM}.txt"

    local TM=$(( RANDOM % 20 ))

    echo "$NUM: sleeping $TM sec"

    sleep $TM

    echo "$NUM: starting"

    ytdl.sh $LINK $NUM >$outp
    local res=$?

    rm $outp

    echo "$NUM: finished"
}

ytdl()
{
    local NUM=$1
    local LINK=$2
    local DATUM=$3

    ytdl_core $NUM $LINK $DATUM
}

DATUM=$(date -u +%Y%m%d_%H%M%S)

CURDIR=$( pwd )

cd $FOLDER

MAX_PARALLEL_DOWNLOADS=10

i=0

for s in $links;
do
    ((i++))

    ytdl $i $s "$DATUM" &

    pid=$!

    pids="$pids $pid"

    if [[ $(( i % MAX_PARALLEL_DOWNLOADS )) == 0 ]]
    then
        echo "INFO: max parallel downloads reached ($MAX_PARALLEL_DOWNLOADS), waiting for completion"
        wait $pids
        pids=""
    fi

done;

echo "waiting for pids $pids"

wait $pids

cd $CURDIR
