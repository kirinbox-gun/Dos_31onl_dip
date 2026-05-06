resource "kubernetes_deployment_v1" "worker_deploy" {
  metadata {
    name      = "worker"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
    labels = {
      app = "worker"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "worker"
      }
    }

    template {
      metadata {
        labels = {
          app = "worker"
        }
      }

      spec {
        container {
          image = "kirinbox/dos_31onl_dip_worker:latest"
          name  = "worker"
        }
      }
    }
  }
}