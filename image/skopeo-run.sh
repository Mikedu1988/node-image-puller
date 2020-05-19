#!/usr/bin/env bash
strB="\|"
sourceImage=""
targetImage=""
while true; do
  #  echo "download image list"
  #  rm imagelist
  cat imagelist | while read LINE; do
    echo ${LINE}
    if [[ ${LINE} =~ ${strB} ]]; then
      sourceImage=$(echo ${LINE} | awk 'BEGIN {FS="|";} { print $1 }')
      targetImage=$(echo ${LINE} | awk 'BEGIN {FS="|";} { print $2 }')
    else
      sourceImage=${LINE}
      targetImage=${LINE}
    fi
    skopeo inspect docker-daemon:${targetImage} >> /dev/null
    if [[ $? -eq 0 ]]; then
      echo "image exists on node, do nothing"
    else
      echo "run command skopeo copy docker://${sourceImage} docker-daemon:${targetImage}"
      skopeo copy docker://${sourceImage} docker-daemon:${targetImage}
    fi
  done
  echo "sleep for 60 seconds"
  sleep 60
done
