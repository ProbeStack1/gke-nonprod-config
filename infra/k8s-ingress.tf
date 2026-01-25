############################################
# DEV INGRESS
############################################
resource "kubernetes_ingress_v1" "dev_ingress" {
  metadata {
    name      = "dev-ingress"
    namespace = "dev"

    annotations = {
      "kubernetes.io/ingress.class"            = "gce"
      "networking.gke.io/managed-certificates" = "dev-cert"
      "networking.gke.io/frontend-config"      = "dev-frontend-config"
      "kubernetes.io/ingress.allow-http"       = "true"
    }
  }

  spec {

    ########################################
    # FALLBACK (ROOT /)
    ########################################
    default_backend {
      service {
        name = "react-vite"
        port {
          number = 80
        }
      }
    }

    rule {
      host = "dev.probestack.io"

      http {

        ####################################
        # API – MOST SPECIFIC FIRST
        ####################################
        path {
          path      = "/probestack/v1/apigee/cutover"
          path_type = "Prefix"

          backend {
            service {
              name = "apigee-cutover"
              port {
                number = 80
              }
            }
          }
        }

        ####################################
        # ADMIN BACKEND
        ####################################
        path {
          path      = "/admin-backend"
          path_type = "Prefix"

          backend {
            service {
              name = "admin-backend"
              port {
                number = 80
              }
            }
          }
        }

        ####################################
        # ADMIN UI
        ####################################
        path {
          path      = "/admin"
          path_type = "Prefix"

          backend {
            service {
              name = "react-admin"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

############################################
# TEST INGRESS (UNCHANGED)
############################################
resource "kubernetes_ingress_v1" "test_ingress" {
  metadata {
    name      = "test-ingress"
    namespace = "test"

    annotations = {
      "kubernetes.io/ingress.class"            = "gce"
      "networking.gke.io/managed-certificates" = "test-cert"
    }
  }

  spec {
    default_backend {
      service {
        name = "placeholder"
        port {
          number = 80
        }
      }
    }

    rule {
      host = "test.probestack.io"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "placeholder"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
