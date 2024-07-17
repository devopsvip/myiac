


helm upgrade --install --create-namespace -n logging elasticsearch ./elasticsearch -f values/es-values.yaml

kubectl get secrets --namespace=logging elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d


helm upgrade --install -n logging kibana ./kibana -f values/kibana-values.yaml

helm upgrade --install fluentbit ./fluent-bit -n logging -f values/fluent-bit-values.yaml  

