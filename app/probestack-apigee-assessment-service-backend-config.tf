resource "kubectl_manifest" "probestack_apigee_assessment_service_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: probestack-apigee-assessment-service-backend-config
  namespace: dev
spec:
  healthCheck:
    requestPath: /probestack/v1/apigee/assessment/actuator/health
    port: 8080
    type: HTTP
YAML
}