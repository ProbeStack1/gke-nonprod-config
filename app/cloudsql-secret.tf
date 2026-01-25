resource "kubernetes_secret" "cloudsql_db_secret" {
  metadata {
    name      = "cloudsql-db-secret"
    namespace = "dev"
  }

  type = "Opaque"

  data = {
    password = var.cloudsql_password
  }
}
