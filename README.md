
## Version info 

### Pre-installed tools
| Name      | Version  | 
|-----------|-----|
| Docker  | 20.10.10  |
| Kind | 1.24.0   | 
| Terraform | 1.1.8 |
| kubectl | 1.24.0 |


### Infrastructure

| Name      | Version  | Details   |
|-----------|-----|---------------|
| Kubernetes  | 1.24.0  | ready  |
| NFS Storage | 2.3.3   | 192.168.1.200 /etc/exports context: /data/storage/kubernetes *(rw,no_root_squash,no_all_squash,sync)  |

### DevOps Applications

| Name      | Version  | Domain   |
|-----------|-----|---------------|
| ArgoCD  | 2.6.7  | [argocd.idevops.site](http://argocd.idevops.site)  |
| Jenkins | 2.415-jdk11 | [jenkins.idevops.site](http://jenkins.idevops.site)  |
| GitLab  | 16.2.2-ce.0  | [gitlab.idevops.site](http://gitlab.idevops.site)  |
| Jenkins Agent | latest-jdk11 | inbound-agent |
| SonarQube | 9.9.0-community | [sonar.idevops.site](http://sonar.idevops.site) |
| Nexus | 3.60.0 | [nexus.idevops.site](http://nexus.idevops.site) |
| Registry  | Tencent TCR | [console.cloud.tencent.com/tcr/repository](https://console.cloud.tencent.com/tcr/repository)|

### Logging Applications


| Name      | Version  | Domain   |
|-----------|-----|---------------|
| ElasticSearch  | 8.5.1  | [es.idevops.site](http://es.idevops.site)  |
| FluentBit | 3.1 |   |
| Kibana  | 8.5.1 | [kibana.idevops.site](http://kibana.idevops.site) |


### Monitoring Applications
| Name      | Version  | Domain   |
|-----------|-----|---------------|
| Grafana  | 11.1.0 | [grafana.idevops.site](http://grafana.idevops.site)  |
| Prometheus | v0.75.1 | [prometheus.idevops.site](http://prometheus.idevops.site)|
| Alertmanager  | v0.27.0  | [alertmanager.idevops.site](http://alertmanage.idevops.site)  |
| node-exporter  | v1.8.1  |  |
| kube-state-metrics  | v2.12.0  |  |
