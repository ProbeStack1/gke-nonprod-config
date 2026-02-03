resource "kubernetes_deployment_v1" "probestack_profile_config_service" {
  metadata {
    name      = "probestack-profile-config-service"
    namespace = "dev"
    labels    = { app = "probestack-profile-config-service" }
  }
  spec {
    replicas = 1
    selector { match_labels = { app = "probestack-profile-config-service" } }
    template {
      metadata { labels = { app = "probestack-profile-config-service" } }
      spec {
        service_account_name = "github-actions-deployer"
        container {
          name  = "probestack-profile-config-service"
          image = var.probestack_profile_config_service_image
          port { container_port = 8080 }

          env {
            name  = "SERVER_SERVLET_CONTEXT_PATH"
            value = "/probestack/v1"
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
              path = "/probestack/v1/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 30
          }
        }
      }
    }
  }
}