#!/bin/sh
source src/getcatalog.src
source src/prcpage.src

catalog=$(getcatalog "g") # | jq '.'
declare -i max
max=$(jq -r '.[].page' <<< "${catalog}" | tail -n 1)
declare -i i
i=0
mkdir -p threads
mkdir -p pages
while [ $i -lt $max ]
do
	jq -r ".[$i]" <<< "${catalog}" | prcpage
	i+=1
done
