

## Deploy kube-prometheus-stack

dokcerimages:
- k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.3.0
- registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.7.0

```
terraform init 
terraform apply --auto-approve

```

result 
```
[root@zeyang-nuc-service monitoring]# kubectl get pod -n monitoring
NAME                                                        READY   STATUS    RESTARTS        AGE
alertmanager-kube-prometheus-stack-alertmanager-0           2/2     Running   1 (2m33s ago)   2m42s
kube-prometheus-stack-grafana-67b674c86d-nb679              3/3     Running   0               2m59s
kube-prometheus-stack-kube-state-metrics-75b97d7857-drc86   1/1     Running   0               2m59s
kube-prometheus-stack-operator-76cb5c7594-wfg2q             1/1     Running   0               2m59s
kube-prometheus-stack-prometheus-node-exporter-c84w7        1/1     Running   0               2m59s
kube-prometheus-stack-prometheus-node-exporter-qvr5d        1/1     Running   0               2m59s
kube-prometheus-stack-prometheus-node-exporter-tsc56        1/1     Running   0               2m59s
prometheus-kube-prometheus-stack-prometheus-0               2/2     Running   0               2m42s
```
