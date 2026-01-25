resource "kubernetes_deployment_v1" "apigee_cutover" {
  metadata {
    name      = "apigee-cutover"
    namespace = "dev"
    labels = {
      app = "apigee-cutover"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "apigee-cutover"
      }
    }

    template {
      metadata {
        labels = {
          app = "apigee-cutover"
        }
      }

      spec {
        service_account_name = "github-actions-deployer"

        container {
          name  = "apigee-cutover"
          image = var.apigee_cutover_image

          port {
            container_port = 8080
          }

          # -------------------------------------------------
          # Application configuration
          # Base path = /probestack/v1/apigee/cutover
          # -------------------------------------------------
          env {
            name  = "SERVER_SERVLET_CONTEXT_PATH"
            value = "/probestack/v1/apigee/cutover"
          }

          env {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "cloud"
          }

          env {
            name  = "SPRING_CLOUD_GCP_PROJECT_ID"
            value = var.project_id
          }

          # -------------------------------------------------
          # MongoDB connection (from Kubernetes Secret)
          # -------------------------------------------------
          env {
            name = "MONGODB_URI"
            value_from {
              secret_key_ref {
                name = "mongodb-secret"
                key  = "MONGODB_URI"
              }
            }
          }

          # -------------------------------------------------
          # Resource limits
          # -------------------------------------------------
          resources {
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
            limits = {
              cpu    = "1"
              memory = "1Gi"
            }
          }

          # -------------------------------------------------
          # Health checks (MUST match context path)
          # -------------------------------------------------
          readiness_probe {
            http_get {
              path = "/probestack/v1/apigee/cutover"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/probestack/v1/apigee/cutover/actuator/health"
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
