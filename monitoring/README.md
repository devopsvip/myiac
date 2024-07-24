

Chart Version:61.3.2

## Install

```

helm upgrade --install -n monitoring kube-stack-prometheus ./kube-prometheus-stack  --create-namespace -f ./kube-prometheus-stack/values.yaml -f ./kube-prometheus-stack/local-values.yaml

```
