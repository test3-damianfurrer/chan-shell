#!/bin/sh
listpageadd(){
  cat -
  ls */ln/*
}
getthreadhead(){
getcommenttxt < "threads/$1/comment.json"
getthreadtext "$1" < "threads/$1/thread.json"
}

source src/picselect.src
source src/getimage.src
source src/getcommenttxt.src
source src/getthreadtext.sh
source src/loadfullthread.src
source src/showthreadreplies.src
cd pages
threadlist=""
for pgd in *
do
	cd $pgd
	threadlist=$(listpageadd <<< "${threadlist}")
	cd ..
done
cd ..
#echo "${threadlist}"
#exit
cd threads
fname=$(picselect <<< "${threadlist}")
#exit
[ "$fname" == "" ] && exit
id=$(awk '{print $1}' FS='/' <<< "$fname")
cd ..
getthreadhead "$id" | xmessage -file - -buttons "exit:0,view:20,id:30" -default "view"
case $? in
  20)
	getimage < "threads/$id/image.json" | dlfullimage "threads/$id/" | sxiv -i
	loadfullthread "$id"
	showthreadreplies "$id"
  ;;
  30)
	echo "$id"
  ;;
  *)
  ;;
esac
