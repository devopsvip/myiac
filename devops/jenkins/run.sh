
## LoadDockerImage
DOCKER_IMAGE=jenkins/jenkins:2.415-jdk11
docker pull ${DOCKER_IMAGE}
kind load  docker-image ${DOCKER_IMAGE} --name devopscluster


## ArgoAPP
kubectl -n argocd apply -f jenkins-argoapp.yaml 