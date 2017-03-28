#!/bin/sh

#http://blog.csdn.net/yangshangwei/article/details/52799882
#docker移除镜像
#docker rm $(docker ps -q -f status=exited)
#docker rmi $(docker images -q -f dangling=true)

processes=`docker ps -q -f status=exited`
if [ -n "$processes" ]; then
  docker rm $processes
fi

images=`docker images -q -f dangling=true`
if [ -n "$images" ]; then
  docker rmi $images
fi