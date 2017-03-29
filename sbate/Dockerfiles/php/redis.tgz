FROM frolvlad/alpine-oraclejdk8:latest
VOLUME /tmp
ADD spring-boot-docker-0.0.1-SNAPSHOT.jar springboot-docker.jar
RUN sh -c 'touch /springboot-docker.jar'
EXPOSE 8080
ENV JAVA_OPTS="-server -Xms128m -Xmx512m"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /springboot-docker.jar" ]