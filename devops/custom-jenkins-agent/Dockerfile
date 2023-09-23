FROM gcr.io/kaniko-project/executor:v1.15.0-debug AS kaniko
FROM jenkins/inbound-agent
USER root

RUN rm -rf /etc/localtime && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' > /etc/timezone

COPY tools/ /tmp
COPY --from=kaniko /kaniko /kaniko
COPY sources.list /etc/apt/sources.list

RUN apt update && apt install -y xz-utils net-tools telnet dnsutils zip unzip curl wget git

RUN tar -C /usr/local/ -zxf /tmp/apache-maven-3.9.1-bin.tar.gz && \
    unzip -d /usr/local/ /tmp/gradle-7.6.1-bin.zip && \
    unzip -d /usr/local/ /tmp/sonar-scanner-cli-4.8.0.2856-linux.zip && \
    tar -C /usr/local/ -xJf /tmp/node-v14.16.1-linux-x64.tar.xz  

ENV M2_HOME=/usr/local/apache-maven-3.9.1 \
    GRADLE_HOME=/usr/local/gradle-7.6.1/  \
    SONAR_SCANNER_HOME=/usr/local/sonar-scanner-4.8.0.2856-linux \
    NODE_HOME=/usr/local/node-v14.16.1-linux-x64 \
    PATH="/kaniko:/usr/local/node-v14.16.1-linux-x64/bin:/usr/local/apache-maven-3.9.1/bin:/usr/local/gradle-7.6.1/bin:/usr/local/sonar-scanner-4.8.0.2856-linux/bin:$PATH"

RUN npm config set registry https://registry.npm.taobao.org && \
    npm install -g yarn && \
    rm -fr /tmp/* 