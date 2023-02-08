terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  insecure    = true
}

resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argo"
  }
}

resource "null_resource" "wait_for_instatll_ingress" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  
      kubectl apply -f ${var.argocd_manifests}/install.yaml -n argo
      printf "\nWaiting for the app.kubernetes.io/name=argocd-server...\n"
      kubectl wait --namespace argo \
        --for=condition=ready pod \
	--selector=app.kubernetes.io/name=argocd-server \
        --timeout=90s

      sleep 20
      kubectl -n argo get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
    EOF
  }

  depends_on = [kubernetes_namespace.argo]
}


resource "null_resource" "wait_for_instatll_argo_ingress" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  
      kubectl apply -f ${var.argocd_manifests}/ingress.yaml -n argo
    EOF
  }

  depends_on = [null_resource.wait_for_instatll_ingress]
}

# argo worflow

resource "null_resource" "wait_for_instatll_argoflow" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  
      kubectl apply -f ${var.argoworkflow_manifests}/install.yaml -n argo
      printf "\nWaiting for the app=workflow-controller...\n"
      kubectl wait --namespace argo \
        --for=condition=ready pod \
	--selector=app=workflow-controller \
        --timeout=90s
    EOF
  }

  depends_on = [kubernetes_namespace.argo]
}


resource "null_resource" "patch_argoflow_server" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      kubectl patch deployment \
        argo-server \
        --namespace argo \
        --type='json' \
        -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
        "server",
        "--auth-mode=server"
      ]}]'
    EOF
  }

  depends_on = [null_resource.wait_for_instatll_argoflow]
}

resource "null_resource" "wait_for_instatll_argoflow_ingress" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  
      kubectl apply -f ${var.argoworkflow_manifests}/ingress.yaml -n argo
    EOF
  }

  depends_on = [null_resource.patch_argoflow_server]
}

