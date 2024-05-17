
## LoadDockerImage
kind load  docker-image jenkins/jenkins:2.415-jdk11 --name devopscluster
kind load  docker-image jenkins/inbound-agent:latest --name devopscluster

## ArgoAPP
kubectl -n argocd apply -f jenkins-argoapp.yaml 


##jenkins
mkdir -p jenkins
chmod -R 777 /data/storage/kubernetes/jenkins

## Jenkins build cache
mkdir -p /data/storage/kubernetes/jenkins-build-cache
chmod -R 777 /data/storage/kubernetes/jenkins-build-cache

## Jenkins agent build workspace
mkdir -p  /data/storage/kubernetes/jenkins-workspace
chmod -R 777 /data/storage/kubernetes/jenkins-workspace