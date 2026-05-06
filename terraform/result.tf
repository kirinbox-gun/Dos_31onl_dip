resource "kubernetes_deployment_v1" "result_deploy" {
  metadata {
    name      = "result"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
    labels = {
      app = "result"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "result"
      }
    }

    template {
      metadata {
        labels = {
          app = "result"
        }
      }

      spec {
        container {
          image = "kirinbox/dos_31onl_dip_result:latest"
          name  = "result"

          port {
            container_port = 4000
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "result_service" {
  metadata {
    name      = "result"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
  }
  spec {
    selector = {
      app = "result"
    }
    port {
      port        = 5001      # внутренний порт
      target_port = 4000
      node_port   = 31001     # порт для результатов
    }

    type = "NodePort"
  }
}