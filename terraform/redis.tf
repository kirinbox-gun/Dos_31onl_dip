resource "kubernetes_deployment_v1" "redis_deploy" {
  metadata {
    name      = "redis"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
    labels = {
      app = "redis"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis"
        }
      }

      spec {
        container {
          image = "redis:7-alpine"
          name  = "redis"

          port {
            container_port = 6379
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "redis_service" {
  metadata {
    name      = "redis" # Имя должно быть именно таким, его ищет приложение
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
  }
  spec {
    selector = {
      app = "redis"
    }
    port {
      port        = 6379
      target_port = 6379
    }

    type = "ClusterIP" # только в кластере
  }
}