resource "kubernetes_service_v1" "probestack_apigee_migration_service" {
  metadata {
    name      = "probestack-apigee-migration-service"
    namespace = "dev"
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
      "cloud.google.com/backend-config" = jsonencode({ default = "probestack-apigee-migration-service-backend-config" })
    }
  }
  spec {
    selector = { app = "probestack-apigee-migration-service" }
    port {
      port        = 80
      target_port = 8080
    }
    type = "NodePort"
  }
}