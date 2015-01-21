#tomcat 8 image 
FROM tomcat:8.0.15-jre8
MAINTAINER Jitendra Chopra <jitendra.chopra@csaa.com>
ADD conf/tomcat-users.xml /usr/local/tomcat/conf/
ADD lib/log4j-1.2.17.jar /usr/local/tomcat/lib/
ADD web.xml /usr/local/tomcat/webapps/manager/WEB-INF/
ADD crt/qa.crt /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/
RUN /usr/lib/jvm/java-8-openjdk-amd64/bin/keytool -import –trustcacert s -file qa.crt -alias QA_CERT -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts -noprompt -storepass changeit
#RUN keytool /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security
ENV CATALINA_OPTS -Denv=DEV -Xmx1024m
VOLUME /usr/local/tomcat/webapps
VOLUME /usr/local/tomcat/conf
EXPOSE 8080
EXPOSE 8009
CMD ["catalina.sh", "run"]
