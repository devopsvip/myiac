



## 功能支持 

- 部署k8s集群 1.24.0 [Done]
- 部署argoCD 2.6.7 [TODO]


## Terraform 使用说明

```
terraform init
terraform plan
terraform apply 

# 仅部署某个资源   
terraform apply -target=docker_container.sonarqube 
````
