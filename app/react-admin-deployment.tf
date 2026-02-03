resource "kubernetes_deployment_v1" "react_admin" {
  metadata {
    name      = "react-admin"
    namespace = "dev"
    labels = {
      app = "react-admin"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "react-admin"
      }
    }

    template {
      metadata {
        labels = {
          app = "react-admin"
        }
      }

      spec {
        container {
          name  = "react-admin"
          image = var.react_admin_image
          image_pull_policy = "Always"

          port {
            container_port = 80
          }

          # -------------------------------------------------
          # ECO-MODE: Very low reservation for Nginx
          # -------------------------------------------------
          resources {
            requests = {
              cpu    = "10m"    # barely any CPU reserved
              memory = "64Mi"   # minimal RAM reserved
            }
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
          }

          readiness_probe {
            http_get {
              path = "/admin"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/admin"
              port = 80
            }
            initial_delay_seconds = 15
            period_seconds        = 20
          }
        }
      }
    }
  }
}