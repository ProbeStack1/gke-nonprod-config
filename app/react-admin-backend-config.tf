resource "kubectl_manifest" "react_admin_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: react-admin-backend-config
  namespace: dev
spec:
  healthCheck:
    port: 80
    # UPDATED: Check / because nginx.conf has a dedicated 'location = /' block for health checks
    requestPath: /
    # Optional: Adjust timeouts if needed, but defaults are usually fine
    type: HTTP
YAML
}