resource "kubernetes_manifest" "admin_backend_backendconfig" {
  manifest = {
    apiVersion = "cloud.google.com/v1"
    kind       = "BackendConfig"
    metadata = {
      name      = "admin-backend-config"
      namespace = "dev"
    }
    spec = {
      healthCheck = {
        port        = 8080
        requestPath = "/health"
      }
    }
  }
}
