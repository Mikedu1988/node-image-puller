#!/usr/bin/env bash
strB="\|"
while true
do
#  echo "download image list"
#  rm imagelist
  cat imagelist| while read LINE
  do
    echo ${LINE}
    if [[ ${LINE} =~ ${strB} ]]
    then
      sourceImage=`echo ${LINE} | awk 'BEGIN {FS="|";} { print $1 }'`
      targetImage=`echo ${LINE} | awk 'BEGIN {FS="|";} { print $2 }'`
      echo "run command skopeo copy docker://${sourceImage} docker-daemon:${targetImage}"
      skopeo copy docker://${sourceImage} docker-daemon:${targetImage}
    else
      echo "run command skopeo copy docker://${LINE} docker-daemon:${LINE}"
      skopeo copy docker://${LINE} docker-daemon:${LINE}
    fi
  done
  echo "sleep for 60 seconds"
  sleep 60
done