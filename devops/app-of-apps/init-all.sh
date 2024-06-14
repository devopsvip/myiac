## LoadDockerImage
kind load  docker-image jenkins/jenkins:2.415-jdk11 --name devopscluster
kind load  docker-image jenkins/inbound-agent:latest --name devopscluster
kind load  docker-image gitlab/gitlab-ce:16.2.2-ce.0 --name devopscluster
kind load  docker-image gitlab/gitlab-runner:alpine-v16.2.0 --name devopscluster

# This image is custom build by myself
kind load  docker-image custom-build-agent:v1 --name devopscluster

# sonarqube
kind load  docker-image sonarqube:9.9.0-community --name devopscluster

# nexus
kind load  docker-image sonatype/nexus3:3.60.0 --name devopscluster

# base docker image for ci 
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/dragonwell:21-anolis --name devopscluster