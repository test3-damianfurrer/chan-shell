#!/bin/sh
getthreadtext(){
thinf=$(cat -)
no="$1"
[ -L "sticky/$no" ] && echo -n "Stickied! "
[ -L "closed/$no" ] && echo -n "Closed! "
echo ""
jq -r '"replies: "+(.replies|tostring)+" / images: "+(.images|tostring)' <<< "${thinf}"
echo -n "last change: "
date -d @$(jq -r '.last_modified' <<< "${thinf}") "+%d.%m.%y %H:%M.%S"
}
