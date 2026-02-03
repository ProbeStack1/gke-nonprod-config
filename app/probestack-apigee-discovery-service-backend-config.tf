resource "kubectl_manifest" "probestack_apigee_discovery_service_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: probestack-apigee-discovery-service-backend-config
  namespace: dev
spec:
  healthCheck:
    requestPath: /probestack/v1/apigee/actuator/health
    port: 8080
    type: HTTP
YAML
}