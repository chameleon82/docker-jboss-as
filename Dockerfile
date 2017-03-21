FROM jboss/base-jdk:7

ENV JBOSS_HOME /opt/jboss-as-7.1.1.Final

RUN cd $HOME \
    && curl -O http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz \
    && tar xf jboss-as-7.1.1.Final.tar.gz \
    && mv $HOME/jboss-as-7.1.1.Final.tar.gz $JBOSS_HOME \
    && rm jboss-as-7.1.1.Final.tar.gz 
    
ENV LAUNCH_JBOSS_IN_BACKGROUND true
    
EXPOSE 8080 9990    

CMD ["/opt/jboss-as-7.1.1.Final/bin/standalone.sh", "-b", "0.0.0.0"]
