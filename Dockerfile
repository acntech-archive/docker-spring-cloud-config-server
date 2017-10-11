FROM acntechie/maven:latest
MAINTAINER Thomas Johansen "thomas.johansen@accenture.com"


ENV ENV_SPRING_CLOUD_CONFIG_SERVER_HOME=/opt/spring-cloud-config-server
ENV ENV_SPRING_CLOUD_CONFIG_SERVER_CONFIG=/opt/spring-cloud-config-server
ENV ENV_SPRING_CLOUD_CONFIG_SERVER_LOGS=/var/log/spring-cloud-config-server


RUN apt-get update && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${ENV_SPRING_CLOUD_CONFIG_SERVER_HOME}
RUN mkdir -p ${ENV_SPRING_CLOUD_CONFIG_SERVER_CONFIG}
RUN mkdir -p ${ENV_SPRING_CLOUD_CONFIG_SERVER_LOGS}


COPY ./resources/pom.xml ${ENV_SPRING_CLOUD_CONFIG_SERVER_HOME}/
COPY ./resources/application.yml ${ENV_SPRING_CLOUD_CONFIG_SERVER_CONFIG}/
COPY ./resources/entrypoint.sh /entrypoint.sh


WORKDIR ${ENV_SPRING_CLOUD_CONFIG_SERVER_HOME}


RUN mvn package
RUN chmod +x /entrypoint.sh


EXPOSE 8888


VOLUME ${ENV_SPRING_CLOUD_CONFIG_SERVER_CONFIG}
VOLUME ${ENV_SPRING_CLOUD_CONFIG_SERVER_LOGS}


ENTRYPOINT ["/entrypoint.sh"]
