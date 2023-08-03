## NFS
mkdir -p /data/storage/kubernetes/gitlab/{config,logs,data}
chmod 777 -R /data/storage/kubernetes/gitlab/ 

mkdir -p /data/storage/kubernetes/gitlab-runner
chmod 777 -R /data/storage/kubernetes/gitlab-runner

## Docker images
docker pull gitlab/gitlab-ce:16.2.2-ce.0
docker pull registry.gitlab.com/gitlab-org/gitlab-runner:alpine-v11.6.0

## LoadDockerImage
kind load  docker-image gitlab/gitlab-ce:16.2.2-ce.0 --name devopscluster
kind load  docker-image registry.gitlab.com/gitlab-org/gitlab-runner:alpine-v11.6.0 --name devopscluster

## ArgoAPP
kubectl -n argocd apply -f gitlab-argoapp.yaml 