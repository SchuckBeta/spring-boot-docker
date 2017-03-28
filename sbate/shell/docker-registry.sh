#!/bin/sh

################################################ Docker私服 ################################################
#博客：http://www.cnblogs.com/lienhua34/p/4922130.html
#
#下载仓库镜像
#	sudo docker pull registry
#	sudo docker pull registry:version
#
#运行镜像
#	运行私服镜像，指定镜像保存在/var/lib/registry目录下
#	镜像映射的端口为5000
#		对应访问地址为：127.0.0.1:5000/v2
#		对应访问地址为：127.0.0.1:5000/v2/_catalog
#	sudo docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry
#	sudo docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry:version
#	sudo docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry:2.1.1
#
#推送镜像到私库
#	查看本地镜像
#		sudo docker images	
#		执行结果如下：
#			仓库镜像名                         标记版本            镜像唯一标识        创建时间            大小
#			REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE
#			registry                           latest              047218491f8c        3 weeks ago         33.2 MB
#			hello-world                        latest              48b5124b2768        2 months ago        1.84 kB
#
#	本地镜像上传至本地仓库（默认使用latest版本）
#		sudo docker tag hello-world 127.0.0.1:5000/hello-world
#
#	查看本地镜像
#		sudo docker images	
#		执行结果如下：
#			仓库镜像名                         标记版本            镜像唯一标识        创建时间            大小
#			REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE
#			registry                           latest              047218491f8c        3 weeks ago         33.2 MB
#			127.0.0.1:5000/sbeta/hello-world   latest              48b5124b2768        2 months ago        1.84 kB
#			hello-world                        latest              48b5124b2768        2 months ago        1.84 kB
#
#查看私库中的镜像
#	访问地址为：127.0.0.1:5000/v2/_catalog
#
#删除镜像
#	删除本地镜像
#		sudo docker rm hello-world
#		sudo docker rmi hello-world 
#		sudo docker rm hello-world:latest
#		sudo docker rmi hello-world:latest
#
#	删除私库
#		sudo docker rm 127.0.0.1:5000/sbeta/hello-world
#		sudo docker rmi 127.0.0.1:5000/sbeta/hello-world 
#  
#注意事项：
#	如果删除镜像时出现找不到镜像（默认是删除latest版本镜像），请指定删除版本
#
#	如果删除镜像时出现Untagged错误，请指定先执行下列命令然后执行删除
#		docker rm $(docker ps -q -f status=exited)
#		docker rmi $(docker images -q -f dangling=true)
#		对应脚本：
#			#!/bin/sh
#			processes=`docker ps -q -f status=exited`
#			if [ -n "$processes" ]; then
#			  docker rm $processes
#			fi
#
#			images=`docker images -q -f dangling=true`
#			if [ -n "$images" ]; then
#			  docker rmi $images
#			fi
#
#	可能会出现无法push镜像到私有仓库的问题。这是因为我们启动的registry服务不是安全可信赖的。这是我们需要修改docker的配置文件/etc/default/docker，添加下面的内容，
#		DOCKER_OPTS="--insecure-registry xxx.xxx.xxx.xxx:5000"
#		然后重启docker后台进程，
#		sudo service docker restart
#

