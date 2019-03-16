#tomcat 8 image 
FROM tomcat:8.0.15-jre8
MAINTAINER Jitendra Chopra <chopra.jitendra@gmail.com>
ADD conf/tomcat-users.xml /usr/local/tomcat/conf/
ADD lib/log4j-1.2.17.jar /usr/local/tomcat/lib/
ADD web.xml /usr/local/tomcat/webapps/manager/WEB-INF/
ADD crt/qa.crt /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/
RUN keytool -import -trustcacerts -file /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/qa.crt -alias QA_CERT -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts -noprompt -storepass changeit
ENV CATALINA_OPTS -Denv=DEV -Xmx1024m
VOLUME /usr/local/tomcat/webapps
VOLUME /usr/local/tomcat/conf
EXPOSE 8080
EXPOSE 8009
CMD ["catalina.sh", "run"]
