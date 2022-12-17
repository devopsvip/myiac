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


resource "helm_release" "kube-prometheus-stack" {
  name       = "kube-prometheus-stack"
  chart      = "./kube-prometheus-stack-42.2.1"
  namespace  = "monitoring"
  depends_on = [null_resource.loaddockerimages]
}


resource "null_resource" "loaddockerimages" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      kind load  docker-image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.3.0  --name test-cluster
      kind load  docker-image registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.7.0 --name test-cluster
    EOF
  }
}
