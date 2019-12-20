#!/bin/sh

tmp=$(mktemp)
#trap "rm -f $tmp" 0

if test $# != 0
then
    while test $# != 0
    do
        rm "$tmp"
        wget -q -O "$tmp" "$1"
        escaped=$(echo "$1" | sed "s/\//\\\\\//g" -)
        wget -q -O "$tmp" $(sed -n "s/.*'\(.*popup.*\)'.*/$escaped\1/p" "$tmp")
        sed -n 's/.*"\(.*vimeo.*\)".*/\1/p' "$tmp"
        shift
    done
    exit
fi

wget -q -O "$tmp" https://www.edunovela.com/coll-spanish-2.html
$(dirname "$0")/spanish.sh $(sed -n "s/.*'\(.*episode.*\)'.*/\1/p" "$tmp")
