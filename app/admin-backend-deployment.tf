resource "kubernetes_deployment_v1" "admin_backend" {
  metadata {
    name      = "admin-backend"
    namespace = "dev"
    labels = {
      app = "admin-backend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "admin-backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "admin-backend"
        }
      }

      spec {

        # =================================================
        # SHARED VOLUME FOR CLOUD SQL SOCKET
        # =================================================
        volume {
          name = "cloudsql"
          empty_dir {}
        }

        # =================================================
        # MAIN APP CONTAINER
        # =================================================
        container {
          name  = "admin-backend"
          image = var.admin_backend_image

          port {
            container_port = 8080
          }

          resources {
            requests = {
              cpu    = "50m"
              memory = "128Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }

          readiness_probe {
            http_get {
              path = "/api"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }

          # ================= ENV =================

          env {
            name  = "ROOT_PATH"
            value = "/admin-backend"
          }

          env {
            name  = "DB_NAME"
            value = "probestack-admin-dev"
          }

          env {
            name  = "DB_USER"
            value = var.cloudsql_user
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = "cloudsql-db-secret"
                key  = "password"
              }
            }
          }

          # IMPORTANT: used by FastAPI DB config
          env {
            name  = "INSTANCE_CONNECTION_NAME"
            value = "${var.project_id}:us-central1:probestack-mysql-nonprod"
          }

          env {
            name  = "AUTH0_DOMAIN"
            value = "probestack-usa-dev.us.auth0.com"
          }

          env {
            name  = "AUTH0_CLIENT_ID"
            value = "3iWcIhLljSPnbGbkQXsSMuPyTQksh8OF"
          }

          env {
            name = "AUTH0_CLIENT_SECRET"
            value_from {
              secret_key_ref {
                name = "auth0-secret"
                key  = "client_secret"
              }
            }
          }

          env {
            name  = "AUTH0_CALLBACK_URI"
            value = "https://dev.probestack.io/callback"
          }

          # Mount socket
          volume_mount {
            name       = "cloudsql"
            mount_path = "/cloudsql"
          }
        }

        # =================================================
        # CLOUD SQL PROXY (FIXED)
        # =================================================
        container {
          name  = "cloud-sql-proxy"
          image = "gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.8.0"

          args = [
            "--unix-socket=/cloudsql",
            "--private-ip",
            "${var.project_id}:us-central1:probestack-mysql-nonprod"
          ]

          security_context {
            run_as_non_root = true
          }

          resources {
            requests = {
              cpu    = "10m"
              memory = "64Mi"
            }
          }

          volume_mount {
            name       = "cloudsql"
            mount_path = "/cloudsql"
          }
        }
      }
    }
  }
}
