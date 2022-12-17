locals {
  volumes = [
    {
      host_path = "/data/devops4/sonarqube/sonarqube_conf"
      container_path      = "/opt/sonarqube/conf"
    },
    {
      host_path = "/data/devops4/sonarqube/sonarqube_extensions"
      container_path      = "/opt/sonarqube/extension"
    },
    {
      host_path = "/data/devops4/sonarqube/sonarqube_logs"
      container_path      = "/opt/sonarqube/logs"
    },
    {
      host_path = "/data/devops4/sonarqube/sonarqube_data"
      container_path      = "/opt/sonarqube/data"
    }
  ]
}


resource "docker_image" "sonar" {
  name         = "sonarqube:8.9.8-community"
  keep_locally = true //销毁时不删除本地镜像
}

resource "docker_container" "sonarqube" {
  image = docker_image.sonar.name
  name  = "sonarqube"
  ports {
    internal = 9000
    external = 9000
  }

  dynamic "volumes" {
    for_each = local.volumes
    content {
      container_path = volumes.value["container_path"]
      host_path      = volumes.value["host_path"]
    }
  }
}
