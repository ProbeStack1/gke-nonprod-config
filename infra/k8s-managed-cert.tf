resource "kubernetes_manifest" "dev_cert" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "ManagedCertificate"

    metadata = {
      name      = "dev-cert"
      namespace = "dev"
    }

    spec = {
      domains = [
        "dev.probestack.io"
      ]
    }
  }
}


resource "kubernetes_manifest" "test_cert" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "ManagedCertificate"
    metadata = {
      name      = "test-cert"
      namespace = "test"
    }
    spec = {
      domains = ["test.probestack.io"]
    }
  }
}
