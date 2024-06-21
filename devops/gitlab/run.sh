## NFS

## Gitlab
mkdir -p /data/storage/kubernetes/gitlab/{config,logs,data}
chmod 777 -R /data/storage/kubernetes/gitlab/ 

## GitLab Runner
mkdir -p /data/storage/kubernetes/gitlab-runner
chmod 777 -R /data/storage/kubernetes/gitlab-runner

## Docker images
docker pull ccr.ccs.tencentyun.com/devopsvip/gitlab-ce:16.2.2-ce.0
docker pull ccr.ccs.tencentyun.com/devopsvip/gitlab-runner:alpine-v16.2.0

## LoadDockerImage
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/gitlab-ce:16.2.2-ce.0 --name devopscluster
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/gitlab-runner:alpine-v16.2.0 --name devopscluster

## ArgoAPP
kubectl -n argocd apply -f gitlab-argoapp.yaml 