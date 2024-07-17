


## Deploy argo applications

1. run init.sh to get docker images and load these docker images to kind cluster.
2. for devops appliations you can run : `cd devops && kubectl apply -f devops-rootapps.yaml` to deploy devops cicd tools.
3. for example, if other apps you can run : `kubectl apply -f es-argoapp.yaml ` to deploy each apps.