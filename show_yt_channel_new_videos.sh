#!/bin/bash

NAME=$1

[[ -z $NAME ]] && echo "ERROR: NAME is not given" && exit

FL=channel_${NAME}_

ls $FL* 2>/dev/null 1>/dev/null
res=$?

#echo "DEBUG: res = $res"

[[ $res -ne 0 ]] && echo "ERROR: cannon find channel files $FL" && exit

FLS=$( ls $FL* 2>/dev/null | tail -2 )

NUM=$( echo $FLS | wc -w )

[[ $NUM -ne 2 ]] && echo "ERROR: not enough files - files expected 2, got $NUM" && exit

show_new_lines.sh $FLS
