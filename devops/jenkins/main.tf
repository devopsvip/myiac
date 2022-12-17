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

resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "devops"
  }
}

resource "kubernetes_deployment_v1" "jenkins" {
  metadata {
    name = "jenkins"
    labels = {
      app = "jenkins"
    }
    namespace = kubernetes_namespace.jenkins.id
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }

      spec {
        container {
          image             = "jenkins/jenkins:2.375.1-jdk11"
          name              = "jenkins"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 8080
            name           = "web"
          }
          port {
            container_port = 50000
            name           = "agent"
          }

          resources {
            limits = {
              cpu    = 2
              memory = "4096Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "1024Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/login"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 3
          }
        }
        volume {
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.pvcjenkins.metadata.0.name
          }
        }
      }
    }
  }
}
