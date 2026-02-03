resource "kubernetes_service_v1" "apigee_cutover" {
  metadata {
    name      = "apigee-cutover"
    namespace = "dev"

    annotations = {
      # CRITICAL: Enable NEG for Container-Native Load Balancing
      "cloud.google.com/neg" = "{\"ingress\": true}"
      
      # Link to the new BackendConfig
      "cloud.google.com/backend-config" = jsonencode({
        default = "apigee-cutover-backend-config"
      })
    }
  }

  spec {
    selector = {
      app = "apigee-cutover"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "NodePort"
  }
}