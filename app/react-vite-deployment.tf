resource "kubernetes_deployment_v1" "react_vite" {
  metadata {
    name      = "react-vite"
    namespace = "dev"
    labels = {
      app = "react-vite"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "react-vite"
      }
    }

    template {
      metadata {
        labels = {
          app = "react-vite"
        }
      }

      spec {
        container {
          name  = "react-vite"
          image = var.react_vite_image

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/"
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
