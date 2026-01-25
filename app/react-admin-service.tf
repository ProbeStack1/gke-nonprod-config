resource "kubernetes_service_v1" "react_admin" {
  metadata {
    name      = "react-admin"
    namespace = "dev"
    labels = {
      app = "react-admin"
    }
  }

  spec {
    selector = {
      app = "react-admin"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
