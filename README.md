
## 功能支持 

- 部署k8s集群 1.24.0 [DONE]
- 部署ArgoCD 2.6.7  [DONE]
- 部署Jenkins 2.415-jdk11 [DONE]
- 部署GitLab [DONE]
- 自定义Jenkins Agent镜像Dockerfile [DONE]
- 部署SonarQube LTS []
- 部署Nexus3 LTS [DONE]

## 目录结构

```
cicd   #Use terraform & docker to deploy apps [SKIP];
devops-tf #Use terraform & kubernetes to deploy apps;
k8s #User terraform & kind to deploy k8s cluster in local;
terraform-plugin-cache #terraform local cache;
devops #Use argocd to deploy devops tools; 
```

## Deploy k8s cluster 

```
cd k8s 

# Terraform init and apply 
terraform init 
terraform apply --auto-approve 

# if deploy failed. please check k8s/resolv.conf;
# you need to update first dns server in file k8s/resolv.conf;
docker network list #  you will find docker network named kind;
docker network inspect kind # get gateway ipaddress then replace first dns server in file k8s/resolv.conf

# Terraform apply again
terraform apply --auto-approve 

# If ok
kubectl get nodes

```

## Deploy argocd in k8s

notice: Please update your local machine /etc/hosts file. add ` k8s_cluster_local_hostip argocd.idevops.site`

```
cd devops/argocd
sh -x run.sh

# if deploy success, access https://argocd.idevops.site 

```

## Deploy all apps 
notice: Must first to deploy argocd.
notice: Please update your /etc/hosts file. add 
- ` k8s_cluster_local_hostip gitlab.idevops.site`
- ` k8s_cluster_local_hostip jenkins.idevops.site`
- ` k8s_cluster_local_hostip sonar.idevops.site`
- ` k8s_cluster_local_hostip nexus.idevops.site`
notice: Argocd use remote git repo apps manifests, so if you need update,please update files from remote git repo.

```
cd devops/app-of-apps
sh -x init-all.sh
kubectl apply -f rootapp.yaml -n argocd
```