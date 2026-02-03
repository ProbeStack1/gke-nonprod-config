resource "kubectl_manifest" "admin_backend_config" {
  yaml_body = <<YAML
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: admin-backend-config
  namespace: dev
spec:
  healthCheck:
    # Use /docs as it is a known working endpoint returning 200 OK
    requestPath: /docs
    # Removing 'port' allows GKE to use the NEG port (8080) automatically
    type: HTTP
  urlRewrite:
    # Rewrite /admin-backend/foo to /foo
    pathPrefixRewrite: /
YAML
}