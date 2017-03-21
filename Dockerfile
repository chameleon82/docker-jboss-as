FROM jboss/base-jdk:7

ENV JBOSS_HOME /opt/jboss-as-7.1.1.Final

RUN cd /tmp && \
    curl -O http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz && \
    tar zxvf /tmp/jboss-as-7.1.1.Final.tar.gz -C /opt && \
    sed -i -r 's/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:0.0.0.0/' && \
    /opt/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml && \
    rm -rf /tmp/* /var/tmp/*
    
EXPOSE 8080 9990    

CMD ["/opt/jboss-as-7.1.1.Final/bin/standalone.sh", "-b", "0.0.0.0"]
