resource "kubernetes_deployment_v1" "vote_deploy" {
  metadata {
    name      = "vote"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
    labels = {
      app = "vote"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "vote"
      }
    }

    template {
      metadata {
        labels = {
          app = "vote"
        }
      }

      spec {
        container {
          # мой образ из Docker Hub
          image = "kirinbox/dos_31onl_dip_vote:latest"
          name  = "vote"

          port {
            container_port = 80 # Порт, на котором слушает само приложение
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "vote_service" {
  metadata {
    name      = "vote"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
  }
  spec {
    selector = {
      app = "vote"
    }
    port {
      port        = 5000     # Внутренний порт сервиса
      target_port = 80       # Порт контейнера
      node_port   = 31000    # Внешний порт на твоем ноуте
    }

    type = "NodePort"
  }
}