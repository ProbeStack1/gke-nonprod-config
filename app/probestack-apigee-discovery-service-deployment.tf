resource "kubernetes_deployment_v1" "probestack_apigee_discovery_service" {
  metadata {
    name      = "probestack-apigee-discovery-service"
    namespace = "dev"
    labels    = { app = "probestack-apigee-discovery-service" }
  }
  spec {
    replicas = 1
    selector { match_labels = { app = "probestack-apigee-discovery-service" } }
    template {
      metadata { labels = { app = "probestack-apigee-discovery-service" } }
      spec {
        service_account_name = "github-actions-deployer"
        container {
          name  = "probestack-apigee-discovery-service"
          image = var.probestack_apigee_discovery_service_image
          port { container_port = 8080 }

          env {
            name  = "SERVER_SERVLET_CONTEXT_PATH"
            value = "/probestack/v1/apigee"
          }
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
              path = "/probestack/v1/apigee/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 30
          }
        }
      }
    }
  }
}