#!/bin/bash

FL_OLD=$1
FL_NEW=$2

[[ -z $FL_OLD ]] && echo "ERROR: FL_OLD is not given" && exit
[[ -z $FL_NEW ]] && echo "ERROR: FL_NEW is not given" && exit

diff --new-line-format='%L' --unchanged-line-format='' --old-line-format='' $FL_OLD $FL_NEW
