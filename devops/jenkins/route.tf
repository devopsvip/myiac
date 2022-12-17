
resource "kubernetes_service_v1" "jenkins" {
  metadata {
    name      = "jenkins-service"
    namespace = kubernetes_namespace.jenkins.id
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.jenkins.metadata[0].labels.app
    }
    port {
      port        = 8080
      target_port = 8080
      name = "web"
    }
    port {
      port        = 50000
      target_port = 50000
      name = "agent"
    }
    type = "ClusterIP"
  }
}


resource "kubernetes_ingress_v1" "jenkins_ingress" {
  metadata {
    name      = "jenkins-ingress"
    namespace = kubernetes_namespace.jenkins.id
  }
  spec {
    rule {
      host = "jenkins.idevops.site"
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.jenkins.metadata[0].name
              port {
                number = 8080
              }
            }
          }
          path_type = "Prefix"
          path      = "/"
        }
      }
    }
  }
}