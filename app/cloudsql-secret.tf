resource "kubernetes_secret_v1" "cloudsql_db_secret" {
  metadata {
    name      = "cloudsql-db-secret"
    namespace = "dev"
  }

  type = "Opaque"

  data = {
    password = var.cloudsql_password
  }
}
