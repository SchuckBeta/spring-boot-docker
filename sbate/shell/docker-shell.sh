#!/bin/sh

################################################ Docker常用命令 ################################################
#博客：http://www.cnblogs.com/lienhua34/p/4922130.html
#
#	centos yum install netstat
#	centos yum install net-tools
#	apt-get install netstat
# curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://5e4f142b.m.daocloud.io
#
#设置远程仓库：(保存在 vim /etc/default/docker)
#	daocloud仓库：
#		sudo echo “DOCKER_OPTS=\”\$DOCKER_OPTS –registry-mirror=http://your-id.m.daocloud.io -d\”” >> /etc/default/docker
#		sudo service docker restart
#
#	阿里云仓库：
#		sudo echo "DOCKER_OPTS=\"--registry-mirror=https://yourlocation.mirror.aliyuncs.com\"" | sudo tee -a /etc/default/docker
#		sudo service docker restart
#
#
#登录远程仓库：(保存在/root/.docker/config.json)
#	sudo docker login
#	sudo docker login http://www.xxx.xxx
#
#
#查找镜像
#	sudo docker search hello
#
#
#下载仓库镜像
#	sudo docker pull registry
#	sudo docker pull registry:version
#
#
#发布仓库镜像
#	sudo docker push registry
#	sudo docker push yourname/registry
#
#
#构建镜像（DockerFile）
#	sudo docker build [options] <path>
#		指定一次-t ，镜像有名称和版本
#				docker build -t test:1.0 .
#		指定多次-t ，只有最后一个镜像有名称，前面都是<none>
#			docker build -t test/restful -t test/manager .
#		不指定-t，新生成的镜像都是<none>
#			docker build .
#	
#
#运行镜像
#	docker run <相关参数> <镜像 ID> <初始命令>
#		-i：表示以“交互模式”运行容器
#		-t：表示容器启动后会进入其命令行
#		-v：表示需要将本地哪个目录挂载到容器中，
#			格式：-v <宿主机目录>:<容器目录>
#	切换模式：	
#		可以使用指定的镜像运行一个shell，如果想退出该终端，可以使用exit命令，
#		或者依次按下CTRL -p+CTRL -q，即可切换到宿主机器。不过这种方式，容器依然在后天运行。
#
#	指定端口映射：-p
#		sudo docker run -p 8080:8080 hello-world
#	指定镜像：-t
#		sudo docker run -p 8080:8080 -t waylau/docker-spring-boot
#	带参数运行：-e
# 		sudo docker run -e "SPRING_PROFILES_ACTIVE=prod" -p 8080:8080 -t springio/gs-spring-boot-docker 
#		sudo docker run -e "JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n" -p 8080:8080 -p 5005:5005 -t springio/gs-spring-boot-docker
#	指定允许模式：-d（-d=true后台模式，-d=false前台模式，docker attach重新挂载容器）
#		sudo docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry
#	设置容器名称：--name 
#		sudo docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry
#	指定文件本地存储：-v（挂载到本地）
#		sudo docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry
#
#
#运行镜像中安装镜像
#	sudo docker run learn/tutorial apt-get install -y ping
#
#
#查看镜像变更
#	sudo docker diff CONTAINER
#
#
#停止镜像
#	sudo docker stop 81c723d22865
#
#
#查看镜像日志
#	sudo docker logs hello-world
#
#
#查看容器
#	所有运行中的容器
#		sudo docker ps	
#	所有容器
#		sudo docker ps -a
#		sudo docker ps -l
#	所有运行中的容器详细
#		docker inspect 容器ID
#
#
#查看本地镜像
#	sudo docker images	
#	sudo docker images -a
#	执行结果如下：
#		仓库镜像名                         标记版本            镜像唯一标识        创建时间            大小				名称
#		REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE				NAMES
#		registry                           latest              047218491f8c        3 weeks ago         33.2 MB			regy
#		hello-world                        latest              48b5124b2768        2 months ago        1.84 kB			hw
#		127.0.0.1:5000/sbeta/hello-world   latest              48b5124b2768        2 months ago        1.84 kB			hw127
#
#
#操作容器：
#	操作运行中容器：
#		docker attach regy
#			docker attach可以attach到一个已经运行的容器的stdin，然后进行命令执行的动作。但是需要注意的是，如果从这个stdin中exit，会导致容器的停止。 
#	操作容器：
#		docker exec -it regy /bin/bash
#		docker exec -i regy /bin/sh
#			只用-i时，由于没有分配伪终端，看起来像pipe执行一样。但是执行结果、命令返回值都可以正确获取。 
#		docker exec -it regy /bin/sh
#			使用-it时，则和我们平常操作console界面类似。而且也不会像attach方式因为退出，导致整个容器退出。这种方式可以替代ssh或者nsenter、nsinit方式，在容器内进行操作。 
#		docker exec -t bb2 /bin/sh
#			如果只使用-t参数，则可以看到一个console窗口，但是执行命令会发现由于没有获得stdin的输出，无法看到命令执行情况。
#
#
#推送镜像到私库
#	本地镜像上传至本地仓库（默认使用latest版本）
#		sudo docker push tag hello-world 127.0.0.1:5000/hello-world
#
#
#查看私库中的镜像
#	访问地址为：127.0.0.1:5000/v2/_catalog
#
#
#删除镜像、容器（需要先删除镜像容器，才能删除父镜像）
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
#
# docker 运行Kubernetes
#   运行Etcd
#     docker run --net=host -d gcr.io/google_containers/etcd:2.0.12 /user/local/bin/etcd
#   运行Etcd(google)
#     docker run --net=host -d gcr.io/google_containers/etcd:2.0.12 /user/local/bin/etcd
#
#   docker 运行Kubernetes
#     docker pull daocloud.io/frostmourner/hyperkube:master-f27425e
#     docker run -d --net=host --privileged daocloud.io/frostmourner/hyperkube:master-f27425e /hyperkub
#   docker 运行Kubernetes(google)
#     docker pull gcr.io/google_containers/hyperkube
#     docker run -d --net=host --privileged gcr.io/google_containers/hyperkube /hyperkub
#
#
#

