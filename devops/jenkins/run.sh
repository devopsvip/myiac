
## LoadDockerImage
kind load  docker-image jenkins/jenkins:2.415-jdk11 --name devopscluster
kind load  docker-image jenkins/inbound-agent:latest --name devopscluster

## ArgoAPP
kubectl -n argocd apply -f jenkins-argoapp.yaml 