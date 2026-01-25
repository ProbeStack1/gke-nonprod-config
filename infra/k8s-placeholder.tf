resource "kubernetes_deployment" "placeholder" {
  metadata {
    name      = "placeholder"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = { app = "placeholder" }
    }

    template {
      metadata {
        labels = { app = "placeholder" }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "placeholder" {
  metadata {
    name      = "placeholder"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    selector = { app = "placeholder" }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
