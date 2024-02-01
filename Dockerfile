FROM container-registry.oracle.com/mysql/community-router:8.3.0 AS base

FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y wget s3fs sudo && \
    cd /tmp && \
    wget https://dev.mysql.com/get/Downloads/MySQL-8.3/mysql-common_8.3.0-1ubuntu22.04_amd64.deb && \
    wget https://dev.mysql.com/get/Downloads/MySQL-8.3/mysql-community-client-core_8.3.0-1ubuntu22.04_amd64.deb && \
    wget https://dev.mysql.com/get/Downloads/MySQL-8.3/mysql-community-client_8.3.0-1ubuntu22.04_amd64.deb && \
    wget https://dev.mysql.com/get/Downloads/MySQL-8.3/mysql-community-client-plugins_8.3.0-1ubuntu22.04_amd64.deb && \
    wget https://dev.mysql.com/get/Downloads/MySQL-Router/mysql-router-community_8.3.0-1ubuntu22.04_amd64.deb && \
    apt-get install -y ./*.deb && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY init.sh /init.sh

COPY --from=base /run.sh /run.sh

ENTRYPOINT ["/init.sh"]
