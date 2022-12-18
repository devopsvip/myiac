terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.8.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "vault" {
  name       = "vault"
  chart      = "./vault-0.23.0"
  namespace  = "vault"
  create_namespace = true
}
