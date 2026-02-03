resource "kubernetes_service_v1" "apigee_edge_mock_service" {
  metadata {
    name      = "apigee-edge-mock-service"
    namespace = "dev"
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
      "cloud.google.com/backend-config" = jsonencode({ default = "apigee-edge-mock-service-backend-config" })
    }
  }
  spec {
    selector = { app = "apigee-edge-mock-service" }
    port {
      port        = 80
      target_port = 8080
    }
    type = "NodePort"
  }
}