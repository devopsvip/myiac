

### Versions

- ElasticSearch  8.5.1
- Kibana 8.5.1
- Fluentd-bit 3.1 

### Docker images
```
docker pull ccr.ccs.tencentyun.com/devopsvip/elasticsearch:8.5.1
docker pull ccr.ccs.tencentyun.com/devopsvip/kibana:8.5.1
docker pull ccr.ccs.tencentyun.com/devopsvip/fluent-bit:3.1
docker pull ccr.ccs.tencentyun.com/devopsvip/busybox:1.30

```

#### How to get helm charts
```
helm repo add elastic https://helm.elastic.co
helm search repo elastic/elasticsearch
helm search repo elastic/kibana
helm fetch --untar elastic/elasticsearch --version 8.5.1
helm fetch --untar elastic/kibana --version 8.5.1

helm repo add fluent https://fluent.github.io/helm-charts
wget https://github.com/fluent/helm-charts/releases/download/fluent-bit-0.47.2/fluent-bit-0.47.2.tgz

```


#### Deploy by helm 
```
helm upgrade --install --create-namespace -n logging elasticsearch ./elasticsearch -f values/es-values.yaml

kubectl get secrets --namespace=logging elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d


helm upgrade --install -n logging kibana ./kibana -f values/kibana-values.yaml

helm upgrade --install fluentbit ./fluent-bit -n logging -f values/fluent-bit-values.yaml
```


