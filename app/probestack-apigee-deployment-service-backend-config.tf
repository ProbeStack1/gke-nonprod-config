resource "kubectl_manifest" "probestack_apigee_deployment_service_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: probestack-apigee-deployment-service-backend-config
  namespace: dev
spec:
  healthCheck:
    # Health check relative to the context path /probestack/v1/apigee
    requestPath: /probestack/v1/apigee/actuator/health
    port: 8080
    type: HTTP
YAML
}