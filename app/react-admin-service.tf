resource "kubernetes_service_v1" "react_admin" {
  metadata {
    name      = "react-admin"
    namespace = "dev"

    annotations = {
      # CRITICAL: Enable Container-Native Load Balancing (NEG)
      # This allows the Load Balancer to talk directly to Pod IP:80
      "cloud.google.com/neg" = "{\"ingress\": true}"
      
      "cloud.google.com/backend-config" = jsonencode({
        ports = {
          "80" = "react-admin-backend-config"
        }
      })
    }

    labels = {
      app = "react-admin"
    }
  }

  spec {
    selector = {
      app = "react-admin"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}