resource "kubernetes_service_v1" "admin_backend" {
  metadata {
    name      = "admin-backend"
    namespace = "dev"

    annotations = {
      # CRITICAL: Enable Container-Native Load Balancing (NEG)
      # This allows the Load Balancer to talk directly to Pod IP:8080
      "cloud.google.com/neg" = "{\"ingress\": true}"

      "cloud.google.com/backend-config" = jsonencode({
        default = "admin-backend-config"
      })
    }
  }

  spec {
    selector = {
      app = "admin-backend"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "NodePort"
  }
}