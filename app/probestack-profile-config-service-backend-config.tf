resource "kubectl_manifest" "probestack_profile_config_service_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: probestack-profile-config-service-backend-config
  namespace: dev
spec:
  healthCheck:
    requestPath: /probestack/v1/actuator/health
    port: 8080
    type: HTTP
YAML
}