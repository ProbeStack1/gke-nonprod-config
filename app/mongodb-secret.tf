resource "kubernetes_secret_v1" "mongodb" {
  metadata {
    name      = "mongodb-secret"
    namespace = "dev"
  }

  data = {
    MONGODB_URI = base64encode(var.mongodb_uri)
  }
}
