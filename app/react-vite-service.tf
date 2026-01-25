resource "kubernetes_service" "react_vite" {
  metadata {
    name      = "react-vite"
    namespace = "dev"
    labels = {
      app = "react-vite"
    }
  }

  spec {
    selector = {
      app = "react-vite"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
