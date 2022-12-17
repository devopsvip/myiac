


## Deploy K8s cluster

dockerimages:
- kindest/node:v1.24.0
- k8s.gcr.io/ingress-nginx/controller:v1.2.0
- k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1

```bash
# install
cd k8s 
terraform init 
terraform apply --auto-approve

# uninstall
terraform destroy --auto-approve 
```

test

```
kubectl get node
NAME                         STATUS   ROLES           AGE     VERSION
test-cluster-control-plane   Ready    control-plane   2m53s   v1.24.0
test-cluster-worker          Ready    <none>          2m19s   v1.24.0
test-cluster-worker2         Ready    <none>          2m20s   v1.24.0
```

ingress-nginx
```
[root@zeyang-nuc-service k8s]# kubectl get pod -n ingress-nginx
NAME                                        READY   STATUS      RESTARTS   AGE
ingress-nginx-admission-create-fbh5n        0/1     Completed   0          5m41s
ingress-nginx-admission-patch-xttkh         0/1     Completed   0          5m41s
ingress-nginx-controller-7bd87766fb-lsv89   1/1     Running     0          5m41s

```
