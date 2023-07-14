

## 功能支持 

- 部署k8s集群 1.24.0 [DONE]
- 部署ArgoCD 2.6.7  [DONE]


## Terraform 使用说明

```
terraform init
terraform plan
terraform apply 

# 仅部署某个资源   
terraform apply -target=docker_container.sonarqube 
````
