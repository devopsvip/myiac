FROM ccr.ccs.tencentyun.com/devopsvip/executor:v1.15.0-debug AS kaniko
FROM ccr.ccs.tencentyun.com/devopsvip/inbound-agent:latest-jdk11
USER root

RUN rm -rf /etc/localtime && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' > /etc/timezone && rm -rf /var/mail /var/spool/mail  #fix kaniko https://github.com/GoogleContainerTools/kaniko/issues/2214

COPY tools/ /tmp
COPY --from=kaniko /kaniko /kaniko
COPY sources.list /etc/apt/sources.list

RUN apt update && apt install -y xz-utils net-tools telnet dnsutils zip unzip curl wget git

RUN tar -C /usr/local/ -zxf /tmp/apache-maven-3.9.1-bin.tar.gz && \
    unzip -d /usr/local/ /tmp/gradle-7.6.1-bin.zip && \
    unzip -d /usr/local/ /tmp/sonar-scanner-cli-4.8.0.2856-linux.zip && \
    tar -C /usr/local/ -xJf /tmp/node-v20.13.1-linux-x64.tar.xz && \
    tar -C /usr/local/ -zxf /tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.11_9.tar.gz

ENV M2_HOME=/usr/local/apache-maven-3.9.1 \
    GRADLE_HOME=/usr/local/gradle-7.6.1/  \
    SONAR_SCANNER_HOME=/usr/local/sonar-scanner-4.8.0.2856-linux \
    NODE_HOME=/usr/local/node-v20.13.1-linux-x64 \
    PATH="/kaniko:/usr/local/node-v20.13.1-linux-x64/bin:/usr/local/apache-maven-3.9.1/bin:/usr/local/gradle-7.6.1/bin:/usr/local/sonar-scanner-4.8.0.2856-linux/bin:$PATH"

#curl -LO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl && \
#wget https://get.helm.sh/helm-v3.13.0-rc.1-linux-amd64.tar.gz
RUN chmod +x /tmp/kubectl && mv /tmp/kubectl /usr/bin/kubectl && \
    tar -zxf /tmp/helm-v3.13.0-rc.1-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && rm -fr linux-amd64

RUN npm config set registry https://registry.npmmirror.com && \
    npm install -g yarn && \
    rm -fr /tmp/*