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

variable "argocd_manifests" {
  type        = string
  description = "argocd install file"
  default     = "argocd/v2.6.0/install.yaml"
}

resource "null_resource" "wait_for_instatll_ingress" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  
      kubectl apply -f ${var.argocd_manifests} -n argo
    EOF
  }

  depends_on = [kubernetes_namespace.argo]
}
