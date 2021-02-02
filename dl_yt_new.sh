#!/bin/bash

NAME=$1
ID=$2

[[ -z $NAME ]] && echo "ERROR: NAME is not given" && exit
[[ -z $ID ]] && echo "INFO: dowloading channel by NAME" || echo "INFO: dowloading channel by ID"

DATUM=$(date -u +%Y%m%d)

[[ ! -d $DATUM ]] && mkdir $DATUM
[[ ! -d $DATUM/$NAME ]] && mkdir $DATUM/$NAME

LIST_NAME=channel_${NAME}_${DATUM}.txt

if [[ -n $ID ]]
then
    dl_yt_channel_list_by_id.sh $ID $NAME $LIST_NAME
else
    dl_yt_channel_list_by_name.sh $NAME $LIST_NAME
fi

echo "INFO: downloaded list"

DIFF_NAME=diff_${LIST_NAME}

show_yt_channel_new_videos.sh $NAME $DIFF_NAME

dl_yt_many.sh $DIFF_NAME $DATUM/$NAME/

echo "DONE"
