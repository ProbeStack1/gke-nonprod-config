resource "kubernetes_service_v1" "admin_backend" {
  metadata {
    name      = "admin-backend"
    namespace = "dev"

    # ✅ REQUIRED for GCE Ingress health checks
    annotations = {
      "cloud.google.com/backend-config" = "{\"default\":\"admin-backend-config\"}"
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
