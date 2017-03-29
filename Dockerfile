FROM daocloud.io/maven:3.3.3

#############################################################################
ADD pom.xml /tmp/build/
RUN cd /tmp/build
RUN cd /tmp/build && mvn -q dependency:resolve

ADD src /tmp/build/src
        #构建应用
RUN cd /tmp/build \
	#列出目录文件 
	&& ls \
	#执行打包命令
	&& mvn -q -DskipTests=true package \
        #列出目录文件	
	&& ls \
        #拷贝编译结果到指定目录
        && mv target/*.jar /app.jar \
        #列出目录文件	
	&& ls \
	#清理编译痕迹
        && cd / && rm -rf /tmp/build \
	#列出目录文件	
	&& ls
		
#RUN cd /target
#############################################################################

VOLUME /tmp
ADD spring-boot-docker-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
