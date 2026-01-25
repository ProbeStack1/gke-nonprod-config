resource "kubernetes_manifest" "dev_frontend_config" {
  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "FrontendConfig"

    metadata = {
      name      = "dev-frontend-config"
      namespace = "dev"
    }

    spec = {
      redirectToHttps = {
        enabled = true
      }
    }
  }
}
