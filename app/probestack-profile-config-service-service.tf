resource "kubernetes_service_v1" "probestack_profile_config_service" {
  metadata {
    name      = "probestack-profile-config-service"
    namespace = "dev"
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
      "cloud.google.com/backend-config" = jsonencode({ default = "probestack-profile-config-service-backend-config" })
    }
  }
  spec {
    selector = { app = "probestack-profile-config-service" }
    port {
      port        = 80
      target_port = 8080
    }
    type = "NodePort"
  }
}