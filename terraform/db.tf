resource "kubernetes_deployment_v1" "db_deploy" {
  metadata {
    name      = "db"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
    labels = {
      app = "db"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "db"
      }
    }

    template {
      metadata {
        labels = {
          app = "db"
        }
      }

      spec {
        container {
          image = "postgres:15-alpine"
          name  = "postgres"

          env {
            name = "POSTGRES_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secrets.metadata[0].name
                key  = "username"
              }
            }
          }
          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secrets.metadata[0].name
                key  = "password"
              }
            }
          }
          
          port {
            container_port = 5432
          }
        }
      }
    }
  }
}

# Внутренний сервис для доступа к базе по имени "db"
resource "kubernetes_service_v1" "db_service" {
  metadata {
    name      = "db"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
  }
  spec {
    selector = {
      app = "db"
    }
    port {
      port        = 5432
      target_port = 5432
    }

    type = "ClusterIP"
  }
}