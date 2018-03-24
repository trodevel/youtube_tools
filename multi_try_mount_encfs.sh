#!/bin/bash

<<'COMMENT'

Multi try mount wrapper for encfs

Copyright (C) 2018 Sergey Kolevatov

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

COMMENT

# SKV
# 18316 - 1.0 - initial version
# 18325 - 1.1 - added exit codes

#<hb>***************************************************************************
#
# multi_try_mount_encfs.sh <MAX_LOGIN_TRIES> [encfs arguments...]
#
# MAX_LOGIN_TRIES     - maximal number of prompts to enter encfs password
#
# encfs arguments     - arguments passed to encfs
#
# RETURN: 0 - success, 1 - failure
#
# Example: multi_try_mount_encfs.sh 3 /encrypted/folder /decrypted/folder
#
#<he>***************************************************************************

show_help()
{
    sed -e '1,/^#<hb>/d' -e '/^#<he>/,$d' $0 | cut -c 3-
}

mount_encfs()
{
    local encfs_args=$*

#    echo "DEBUG: encfs_args      = $encfs_args"

    echo "enter password (try $try)"
    encfs $encfs_args
    return $?
}

multi_try_mount_encfs()
{
    local encfs_args=$*
    local try=1
    mount_encfs $encfs_args
    local res=$?

    ((try++));

    [[ $res -eq 0 ]] && return 1

    while (( try <= MAX_LOGIN_TRIES ))
    do
        mount_encfs $encfs_args
        res=$?
        [[ $res -eq 0 ]] && return 1
        ((try++))
    done

    return 0
}

MAX_LOGIN_TRIES=$1
shift
encfs_args=$*

[ -z $MAX_LOGIN_TRIES ]    && echo "ERROR: MAX_LOGIN_TRIES is not defined" && show_help && exit
[ $MAX_LOGIN_TRIES -eq 0 ] && echo "ERROR: MAX_LOGIN_TRIES must be greater than 0" && show_help && exit

#echo "DEBUG: MAX_LOGIN_TRIES = $MAX_LOGIN_TRIES"
#echo "DEBUG: encfs_args      = $encfs_args"

multi_try_mount_encfs $encfs_args
res=$?

[[ $res -eq 0 ]] && echo "ERROR: cannot mount encfs" && exit 1

echo "password OK"

exit 0
