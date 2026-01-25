resource "kubernetes_service_v1" "apigee_cutover" {
  metadata {
    name      = "apigee-cutover"
    namespace = "dev"
  }

  spec {
    selector = {
      app = "apigee-cutover"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "NodePort"
  }
}
