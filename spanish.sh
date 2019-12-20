# spanish-unblocker -- gets links to unblock for AP Spanish
# version 1.0, December 20th, 2019
#
# Copyright (C) 2019 Armend Murtishi
#
# This software is provided 'as-is', without any express or implied
# warranty.  In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.
#
# Armend Murtishi armend@armend.cc

#!/bin/sh

tmp=$(mktemp)
trap "rm -f $tmp" 0

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
