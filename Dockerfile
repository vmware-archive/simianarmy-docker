FROM tomcat:8
MAINTAINER greg@curvelogic.co.uk

RUN apt-get update && apt-get install -y curl gettext \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -Lk https://bintray.com/artifact/download/netflixoss/maven/com/netflix/simianarmy/simianarmy/2.5.0/simianarmy-2.5.0.war > /tmp/simianarmy-2.5.0.war

RUN mkdir /etc/simianarmy
RUN mkdir /etc/simianarmy-defaults
COPY *.properties /etc/simianarmy-defaults/
COPY server.xml /usr/local/tomcat/conf/server.xml

# Drop the latest SimianArmy snapshot into tomcat webapps
RUN mkdir /usr/local/tomcat/webapps/simianarmy && \
    cd /usr/local/tomcat/webapps/simianarmy && \
    mv /tmp/simianarmy-2.5.0.war simianarmy-2.5.0.war && \
    unzip /usr/local/tomcat/webapps/simianarmy/simianarmy-2.5.0.war && \
    rm -rf /usr/local/tomcat/webapps/examples && \
    rm -rf /usr/local/tomcat/webapps/manager && \
    rm -rf /usr/local/tomcat/webapps/host-manager

RUN mkdir /usr/local/simianarmy
WORKDIR /usr/local/simianarmy
COPY entrypoint.sh /usr/local/simianarmy/entrypoint.sh
RUN chmod 0755 /usr/local/simianarmy/entrypoint.sh 

# Set these to override values in the config files at startup time
ENV AWS_REGION "eu-west-1"
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV CHAOS_LEASHED true
ENV JANITOR_LEASHED true
ENV VOLUME_TAGGING_LEASHED true
ENV CONFORMITY_LEASHED true

ENTRYPOINT ["/usr/local/simianarmy/entrypoint.sh"]
CMD ["catalina.sh", "run"]
