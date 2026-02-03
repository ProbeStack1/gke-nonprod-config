resource "kubectl_manifest" "probestack_apigee_migration_service_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: probestack-apigee-migration-service-backend-config
  namespace: dev
spec:
  healthCheck:
    requestPath: /probestack/v1/apigee/migration/actuator/health
    port: 8080
    type: HTTP
YAML
}