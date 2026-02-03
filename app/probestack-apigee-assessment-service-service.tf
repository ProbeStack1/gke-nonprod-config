resource "kubernetes_service_v1" "probestack_apigee_assessment_service" {
  metadata {
    name      = "probestack-apigee-assessment-service"
    namespace = "dev"
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
      "cloud.google.com/backend-config" = jsonencode({ default = "probestack-apigee-assessment-service-backend-config" })
    }
  }
  spec {
    selector = { app = "probestack-apigee-assessment-service" }
    port {
      port        = 80
      target_port = 8080
    }
    type = "NodePort"
  }
}