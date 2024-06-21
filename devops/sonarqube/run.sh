## NFS

## sonarqube
mkdir -p /data/storage/kubernetes/sonarqube/{conf,logs,data,extensions}
chmod 777 -R /data/storage/kubernetes/sonarqube/

## Docker images
docker pull ccr.ccs.tencentyun.com/devopsvip/sonarqube:9.9.0-community

## LoadDockerImage
kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/sonarqube:9.9.0-community --name devopscluster

## ArgoAPP
kubectl -n argocd apply -f sonarqube-argoapp.yaml 