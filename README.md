
## 功能支持 

- 部署k8s集群 1.24.0 [DONE]
- 部署ArgoCD 2.6.7  [DONE]
- 部署Jenkins 2.415-jdk11 [DONE]
- 部署GitLab [DONE]
- 自定义Jenkins Agent镜像Dockerfile [DONE]
- 部署SonarQube LTS [TODO]
- 部署Nexus3 LTS [TODO]


## Terraform 使用说明

```
terraform init
terraform plan
terraform apply 

# 仅部署某个资源   
terraform apply -target=docker_container.sonarqube 
````

### 部署说明

- Step1 : Deploy Kubernetes cluster
- Step2 : Deploy ArgoCD
- Step3 : Deploy Jenkins 
- Step4 : Deploy GitLab