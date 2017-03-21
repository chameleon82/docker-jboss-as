FROM alpine:latest

ENV JBOSS_HOME /usr/local/jboss/jboss-as-7.1.1.Final

RUN groupadd -r jboss -g 1000 \
 && useradd -u 1000 -r -g jboss -m -d /usr/local/jboss -s /sbin/nologin -c "JBoss user" jboss \
 && chmod 755 /usr/local/jboss \ 
 && apk --no-cache upgrade \
 && apk --no-cache add openjdk7 \
 && apk --no-cache add curl
       
RUN /usr/local/jboss \
 && curl -O http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz \
 && tar xf jboss-as-7.1.1.Final.tar.gz \
 && rm jboss-as-7.1.1.Final.tar.gz 
# /usr/jboss/jboss-as-7.1.1.Final/bin/jboss-cli.sh --command="module add --name=com.oracle.jdbc --resources=/var/tmp/ojdbc7.jar --dependencies=javax.api,javax.transaction.api" && \
# /usr/jboss/jboss-as-7.1.1.Final/bin/jboss-cli.sh --commands=embed-server,/subsystem=datasources/jdbc-driver=oracle:add\(driver-name=ojbdc7,driver-module-name=com.oracle.jdbc,driver-xa-datasource-class-name=oracle.jdbc.xa.client.OracleXADataSource\),stop-embedded-server && \  
RUN /usr/jboss/jboss-as-7.1.1.Final/bin/add-user.sh admin admin --silent 

ENV LAUNCH_JBOSS_IN_BACKGROUND true
    
USER jboss

EXPOSE 8080 9990    

CMD ["/usr/jboss/jboss-as-7.1.1.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]]
