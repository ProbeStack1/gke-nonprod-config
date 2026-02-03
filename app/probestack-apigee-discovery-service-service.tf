resource "kubernetes_service_v1" "probestack_apigee_discovery_service" {
  metadata {
    name      = "probestack-apigee-discovery-service"
    namespace = "dev"
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
      "cloud.google.com/backend-config" = jsonencode({ default = "probestack-apigee-discovery-service-backend-config" })
    }
  }
  spec {
    selector = { app = "probestack-apigee-discovery-service" }
    port {
      port        = 80
      target_port = 8080
    }
    type = "NodePort"
  }
}