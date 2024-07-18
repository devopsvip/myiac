


helm upgrade --install --create-namespace -n logging elasticsearch ./elasticsearch -f elasticsearch/values.yaml  -f elasticsearch/es-values.yaml

kubectl get secrets --namespace=logging elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d

helm upgrade --install -n logging kibana ./kibana -f kibana/values.yaml -f kibana/kibana-values.yaml

helm upgrade --install fluentbit ./fluentbit -n logging -f fluentbit/values.yaml -f fluentbit/fluentbit-values.yaml