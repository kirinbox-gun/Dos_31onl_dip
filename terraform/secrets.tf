resource "kubernetes_secret_v1" "db_secrets" {
  metadata {
    name      = "db-passwords"
    namespace = kubernetes_namespace_v1.dipl_zone.metadata[0].name
  }

  data = {
    username = var.db_user
    password = var.db_password
  }

  type = "Opaque"
}