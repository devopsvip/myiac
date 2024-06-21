# GitLab
docker pull ccr.ccs.tencentyun.com/devopsvip/gitlab-ce:16.2.2-ce.0
docker pull ccr.ccs.tencentyun.com/devopsvip/gitlab-runner:alpine-v16.2.0
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/gitlab-ce:16.2.2-ce.0 --name devopscluster
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/gitlab-runner:alpine-v16.2.0 --name devopscluster

# Jenkins & Agent
docker pull ccr.ccs.tencentyun.com/devopsvip/jenkins:2.415-jdk11
docker pull ccr.ccs.tencentyun.com/devopsvip/inbound-agent:latest-jdk11
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/jenkins:2.415-jdk11 --name devopscluster
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/inbound-agent:latest-jdk11 --name devopscluster

# This jenkins agent image is custom build by myself local environment
#[TODO] after course end then upload image to tencent tcr. 
kind load  docker-image custom-build-agent:v2 --name devopscluster

# sonarqube
docker pull ccr.ccs.tencentyun.com/devopsvip/sonarqube:9.9.0-community
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/sonarqube:9.9.0-community --name devopscluster

# nexus
docker pull ccr.ccs.tencentyun.com/devopsvip/nexus3:3.60.0
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/nexus3:3.60.0 --name devopscluster

# base docker image for ci 
docker pull ccr.ccs.tencentyun.com/devopsvip/dragonwell:21-anolis
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/dragonwell:21-anolis --name devopscluster