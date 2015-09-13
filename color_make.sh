#!/bin/bash

# from http://stackoverflow.com/questions/2437976/get-color-output-in-bash
# d109

pathpat="(^[A-Za-z0-9_+\./-]*)*:[0-9]+:[0-9]+"
ccred=$(echo -e "\033[0;31m")
ccyellow=$(echo -e "\033[0;33m")
ccend=$(echo -e "\033[0m")
make "$@" 2>&1 | sed -E -e "/[Ee]rror[: ]/ s%${pathpat}%${ccred}&${ccend}%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g" # orig
