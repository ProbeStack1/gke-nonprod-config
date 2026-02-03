resource "kubernetes_service_v1" "probestack_apigee_deployment_service" {
  metadata {
    name      = "probestack-apigee-deployment-service"
    namespace = "dev"
    annotations = {
      # Enable Container-Native Load Balancing
      "cloud.google.com/neg" = "{\"ingress\": true}"
      # Link to the BackendConfig defined above
      "cloud.google.com/backend-config" = jsonencode({
        default = "probestack-apigee-deployment-service-backend-config"
      })
    }
  }
  spec {
    selector = {
      app = "probestack-apigee-deployment-service"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "NodePort"
  }
}