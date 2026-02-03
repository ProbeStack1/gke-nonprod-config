resource "kubernetes_deployment_v1" "apigee_edge_mock_service" {
  metadata {
    name      = "apigee-edge-mock-service"
    namespace = "dev"
    labels    = { app = "apigee-edge-mock-service" }
  }
  spec {
    replicas = 1
    selector { match_labels = { app = "apigee-edge-mock-service" } }
    template {
      metadata { labels = { app = "apigee-edge-mock-service" } }
      spec {
        service_account_name = "github-actions-deployer"
        container {
          name  = "apigee-edge-mock-service"
          image = var.apigee_edge_mock_service_image # Ensure variable exists
          port { container_port = 8080 }

          env {
            name  = "SERVER_SERVLET_CONTEXT_PATH"
            value = "/v1"
          }
          # Add other env vars...
          resources {
            requests = {
              cpu    = "50m"
              memory = "300Mi"
            }
            limits = {
              cpu    = "1000m"
              memory = "1Gi"
            }
          }
          readiness_probe {
            http_get {
              path = "/v1/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 30
          }
        }
      }
    }
  }
}