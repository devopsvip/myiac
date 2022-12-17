resource "kubernetes_persistent_volume_v1" "pvjenkins" {
  metadata {
    name = "pv-jenkins"
  }
  spec {
    capacity = {
      storage = "20Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      nfs {
        path   = "/data/storage/kubernetes/apps-jenkins"
        server = "192.168.1.200"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "pvcjenkins" {
  metadata {
    name = "pvc-jenkins"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "20Gi"
      }
    }
    storage_class_name = ""
    volume_name = kubernetes_persistent_volume_v1.pvjenkins.metadata.0.name
  }
}