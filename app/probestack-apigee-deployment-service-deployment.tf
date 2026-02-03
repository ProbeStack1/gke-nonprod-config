resource "kubernetes_deployment_v1" "probestack_apigee_deployment_service" {
  metadata {
    name      = "probestack-apigee-deployment-service"
    namespace = "dev"
    labels    = { app = "probestack-apigee-deployment-service" }
  }
  spec {
    replicas = 1
    selector { match_labels = { app = "probestack-apigee-deployment-service" } }
    template {
      metadata { labels = { app = "probestack-apigee-deployment-service" } }
      spec {
        service_account_name = "github-actions-deployer"
        container {
          name  = "probestack-apigee-deployment-service"
          # Ensure this variable is defined in your variables.tf
          image = var.probestack_apigee_deployment_service_image
          port { container_port = 8080 }

          # === CONTEXT PATH ===
          # Handles both /deployments and /proxies/validate
          env {
            name  = "SERVER_SERVLET_CONTEXT_PATH"
            value = "/probestack/v1/apigee"
          }

          env {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "cloud"
          }

          # Add other necessary env vars (DB, Mongo, etc.) here
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
          # === HEALTH CHECKS ===
          readiness_probe {
            http_get {
              path = "/probestack/v1/apigee/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/probestack/v1/apigee/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 60
            period_seconds        = 20
          }
        }
      }
    }
  }
}