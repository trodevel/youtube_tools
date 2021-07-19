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
    local TRY_NUM=$4
    local outp="/tmp/ytdl_${DATUM}_${NUM}_${RANDOM}.txt"

    local TM=$(( RANDOM % 20 ))

    echo "$NUM: sleeping $TM sec"

    sleep $TM

    echo "$NUM: starting (try $TRY_NUM)"

    ytdl.sh $LINK $NUM >$outp
    local res=$?

    rm $outp

    local resolution="finished"

    if [[ $res -ne 0 ]]
    then
        resolution="failed"
    fi

    echo "$NUM: $resolution"

    return $res
}

ytdl()
{
    local NUM=$1
    local LINK=$2
    local DATUM=$3

    local i=1

    while [ $i -le $MAX_NUM_RETRIES ]
    do
        ytdl_core $NUM $LINK $DATUM $i
        local res=$?
        [[ $res -eq 0 ]] && break
        i=$[$i+1]
    done
}

start()
{
    local ALL_LINKS=$1
    local PAGE_SIZE=$2
    local DATUM=$3
    local INST_NUM=$4

    local first_link=$(( ( INST_NUM - 1 ) * PAGE_SIZE ))
    local last_link=$(( INST_NUM * PAGE_SIZE ))
    local next_first_link=$(( 1 + INST_NUM * PAGE_SIZE ))

    echo "[$INST_NUM] DEBUG: first_link=$first_link last_link=$last_link next_first_link=$next_first_link"

    local links=$( echo $ALL_LINKS | sed -n "$first_link,${last_link}p;${next_first_link}q" )

    local num_links=$( echo $links | wc -w )

    echo "[$INST_NUM] DEBUG: num_links=$num_links"
}

DATUM=$(date -u +%Y%m%d_%H%M%S)

CURDIR=$( pwd )

cd $FOLDER

MAX_PARALLEL_DOWNLOADS=10

PAGE_SIZE=$(( 1 + num_links / MAX_PARALLEL_DOWNLOADS ))

echo "DEBUG: page size = $PAGE_SIZE"

for i in $(seq 1 $MAX_PARALLEL_DOWNLOADS)
do
    start "$links" $PAGE_SIZE "$DATUM" $i &

    pid=$!

    pids="$pids $pid"

done;

echo "waiting for pids $pids"

wait $pids

cd $CURDIR
