## NFS

## sonarqube
mkdir -p /data/storage/kubernetes/nexus
chmod 777 -R /data/storage/kubernetes/nexus

## Docker images
docker pull sonatype/nexus3:3.60.0

## LoadDockerImage
kind load  docker-image sonatype/nexus3:3.60.0 --name devopscluster

## ArgoAPP
kubectl -n argocd apply -f nexus-argoapp.yaml 