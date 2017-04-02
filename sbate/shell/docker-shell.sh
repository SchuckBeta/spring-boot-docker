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
#######################################################################################################################
#
# docker 运行Kubernetes
#   运行Etcd
#     docker pull docker.io/elcolio/etcd:2.0.5
#     docker run --net=host -d docker.io/elcolio/etcd:2.0.5 /user/local/bin/etcd
#      docker run \
#        -d \
#        -p 2379:2379 \
#        -p 2380:2380 \
#        -p 4001:4001 \
#        -p 7001:7001 \
#        -v /data/backup/dir:/data \
#        --name some-etcd \
#        elcolio/etcd:latest \
#        -name some-etcd \
#        -discovery=https://discovery.etcd.io/blahblahblahblah \
#        -advertise-client-urls http://192.168.1.99:4001 \
#        -initial-advertise-peer-urls http://192.168.1.99:7001
#
#
#
#   运行Etcd(google)
#     docker pull gcr.io/google_containers/etcd:2.0.12
#     docker run --net=host -d gcr.io/google_containers/etcd:2.0.12 /user/local/bin/etcd
#
#   docker 运行Kubernetes 
#     docker pull daocloud.io/frostmourner/hyperkube:master-f27425e
#     docker run -d --net=host --privileged daocloud.io/frostmourner/hyperkube:master-f27425e /hyperkub
#   docker 运行Kubernetes(google)
#     docker pull gcr.io/google_containers/hyperkube
#     docker run -d --net=host --privileged gcr.io/google_containers/hyperkube /hyperkub
#
#   docker 运行Kubernetes 
#     docker pull daocloud.io/frostmourner/hyperkube:master-f27425e
#     docker run -d --net=host --privileged daocloud.io/frostmourner/hyperkube:master-f27425e /hyperkub
#   docker 运行Kubernetes(google)
#     docker pull gcr.io/google_containers/hyperkube
#     docker run -d --net=host --privileged gcr.io/google_containers/hyperkube /hyperkub
#
#######################################################################################################################
#
#   运行Mysql
#     docker pull daocloud.io/library/mysql:8
#   启动一个 mysql 服务实例
#     docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d daocloud.io/mysql:tag
#        在上述命令中，some-mysql 指定了该容器的名字，my-secret-pw 指定了 root 用户的密码，tag 参数指定了你想要的 MySQL 版本。
#   从另外一个 Docker 容器连接 MySQL 服务
#        本镜像会暴露 MySQL 的标准端口 3306，你可以使用 link 功能来让其他应用容器能够访问 MySQL 容器，就像下面这样：
#        docker run --name some-app --link some-mysql:mysql -d app-that-uses-mysql#
#   使用 MySQL 命令行工具连接 MySQL
#        下面的命令启动了另一个 MySQL 容器并使用 MySQL 命令行工具访问你之前的 MySQL 服务，之后你就能向你的数据库执行 SQL 语句了：
#        docker run -it --link some-mysql:mysql --rm daocloud.io/mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
#        在上述命令中 some-mysql 就是你原来 MySQL 服务容器的名字
#   查看 MySQL 日志
#        docker exec 命令能让你在一个容器中额外地运行新命令。比如你可以执行下面的命令来获得一个 bash shell：
#        docker exec -it some-mysql bash
#   你可以通过查看 Docker 容器的日志获得 MySQL 服务的日志：
#        docker logs some-mysql
#   使用自定义 MySQL 配置文件
#        当 MySQL 服务启动时会以 /etc/mysql/my.cnf 为配置文件，本文件会导入 /etc/mysql/conf.d 目录中所有以 .cnf 为后缀的文件。这些文件会拓展或覆盖 /etc/mysql/my.cnf 文件中的配置。因此你可以创建你自己需要的配置文件并挂载至 MySQL 容器中的 /etc/mysql/conf.d 目录。
#        假设 /my/custom/config-file.cnf 是你自定义的配置文件，你可以像这样启动一个 MySQL 容器（注意这里直接挂载了配置文件的目录）：
#        docker run --name some-mysql -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d daocloud.io/mysql:tag
#        这会启动一个名为 some-mysql 且同时加载了 /etc/mysql/my.cnf 和 /etc/mysql/conf.d/config-file.cnf 这两个配置文件的新容器，注意这时以后者的配置优先。
#   SELinux 用户在这里可能会遇到一个问题，目前的解决方法是为你的配置文件指定相关的 SELinux 策略配置，那样容器才可以访问它：
#        chcon -Rt svirt_sandbox_file_t /my/custom
#   环境变量
#     当你启动 mysql 镜像时，你可以通过 docker run 命令传递几个特定的环境变量来调整相关设置，特别注意当容器启动时，所有环境变量都不会影响一个容器中已存在的数据库内容。
#     MYSQL_ROOT_PASSWORD
#       本变量必填，它指定了 MySQL root 的用户的密码。在刚才的例子中，该密码被设置为 my-secret-pw。
#     MYSQL_DATABASE
#       本变量可选，通过该变量当 MySQL 启动时会创建一个由你指定的数据库。如果你另外又提供了一对用户名和密码（见下方），那么他将会被授予本数据库的所有权限。
#     MYSQL_USER, MYSQL_PASSWORD
#       这两个变量可选，同时使用的话会创建一个新用户并设置相应的密码，该用户会被授予由 MYSQL_DATABASE 变量指定的数据库的所有权限（见上方）。只有当同时提供了这两个变量时该用户才会被创建。
#       特别注意没有必要使用这个机制来创建 root 用户，root 用户的密码会被设置为 MYSQL_ROOT_PASSWORD 变量的值。
#     MYSQL_ALLOW_EMPTY_PASSWORD
#       本变量可选，当其被设置为 yes 时将会允许当前容器中的 root 用户能够使用空密码。注意：绝对不建议将该变量设置为 yes，除非你知道自己在做什么。如果这么做的话你的 MySQL 服务将会失去保护，所有人都可以以超级用户的身份访问该 MySQL 服务。
#   重要说明
#     储存数据的位置
#       摘要：下面介绍了多种储存 Docker 容器中数据的方式，我们鼓励 mysql 镜像用户熟悉下面各项技术：
#           使用 Docker 自带的 Volume 机制将数据库文件写入宿主机的磁盘。这是默认的方式，对用户来讲简单且透明。缺点是宿主机上的工具或应用可能难以定位这些文件。
#           在宿主机上创建一个数据目录（在容器外部）并把他挂载至容器内部。此时数据库文件被放置在宿主机上一个已知的目录里，那样容器外部的应用和工具就可以方便地访问这些文件。缺点是用户需要确保这些目录存在，且宿主机上正确配置了权限设置。
#       
#           阅读 Docker 文档能快速了解不同的储存选项，并且有很多博客或论坛讨论并给出了这方面的建议。我们会在下面简单地演示一下：
#             在宿主机上创建一个数据目录，例：/my/own/datadir。
#             使用下面的命令启动 mysql 容器：
#               docker run --name some-mysql -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d daocloud.io/mysql:tag
#             我们通过 -v /my/own/datadir:/var/lib/mysql 参数从宿主机挂载 /my/own/datadir 目录至容器内作为 /var/lib/mysql 目录，那样 MySQL 就会默认将数据文件写入这个目录中。
#        注意 SELinux 用户可能会遇到一个问题，目前的解决方法是为你的数据目录指定相关的 SELinux 策略配置，那样容器才可以访问它：
#             chcon -Rt svirt_sandbox_file_t /my/own/datadir
#
#######################################################################################################################

