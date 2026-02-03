resource "kubectl_manifest" "apigee_edge_mock_service_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: apigee-edge-mock-service-backend-config
  namespace: dev
spec:
  healthCheck:
    requestPath: /v1/actuator/health
    port: 8080
    type: HTTP
YAML
}