#!/bin/bash

set -e

java \
    -Djava.security.egd=file:/dev/./urandom \
    -jar ${ENV_SPRING_CLOUD_CONFIG_SERVER_HOME}/target/spring-cloud-config-server.jar \
    --server.port=8888 \
    --spring.config.name=application
