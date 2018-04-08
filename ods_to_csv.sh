#!/bin/bash

<<'COMMENT'

Wrapper to convert ODS to CSV using LibreOffice

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
# 18408 - 1.0 - initial version

#<hb>***************************************************************************
#
# ods_to_csv.sh <ods_file>
#
# convert ODS file into CSV file using semicolon as a delimeter
#
# Example: ods_to_csv.sh example.ods
#
#<he>***************************************************************************

show_help()
{
    sed -e '1,/^#<hb>/d' -e '/^#<he>/,$d' $0 | cut -c 3-
}

FILTER="Text - txt - csv (StarCalc)"
FILTER_OPTIONS="59,34,0"

INPUT_FILE=$1

[ -z "$INPUT_FILE" ]    && echo "ERROR: INPUT_FILE is not defined" && show_help && exit
[ ! -f "$INPUT_FILE" ]  && echo "ERROR: INPUT_FILE doesn't exist" && show_help && exit

#echo "DEBUG: INPUT_FILE     = $INPUT_FILE"
#echo "DEBUG: FILTER         = $FILTER"
#echo "DEBUG: FILTER_OPTIONS = $FILTER_OPTIONS"

libreoffice --headless --convert-to csv:"$FILTER":"$FILTER_OPTIONS" $INPUT_FILE

#echo "res=$?"
