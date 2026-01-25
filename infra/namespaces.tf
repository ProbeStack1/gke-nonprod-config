resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"

    labels = {
      environment = "dev"
      tier        = "nonprod"
    }
  }
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"

    labels = {
      environment = "test"
      tier        = "nonprod"
    }
  }
}
