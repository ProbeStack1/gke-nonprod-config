resource "kubectl_manifest" "apigee_cutover_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: apigee-cutover-backend-config
  namespace: dev
spec:
  healthCheck:
    # Matches your Deployment's readiness probe
    requestPath: /probestack/v1/apigee/cutover
    type: HTTP
YAML
}