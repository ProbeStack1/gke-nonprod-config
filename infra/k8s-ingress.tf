############################################
# DEV INGRESS
############################################
resource "kubernetes_ingress_v1" "dev_ingress" {
  metadata {
    name      = "dev-ingress"
    namespace = "dev"

    annotations = {
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = "k8s2-fr-734r7o23-dev-dev-ingress-dfmax50w"
      "networking.gke.io/managed-certificates"      = "dev-cert"
      "networking.gke.io/frontend-config"           = "dev-frontend-config"
      "kubernetes.io/ingress.allow-http"            = "true"
    }
  }

  spec {
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

        # ====================================================
        # 1. APIGEE MOCK SERVICE (/v1)
        # ====================================================
        path {
          path      = "/v1"
          path_type = "Prefix"
          backend {
            service {
              name = "apigee-edge-mock-service"
              port { number = 80 }
            }
          }
        }

        # ====================================================
        # 2. PROFILE CONFIG SERVICE
        # (Grouped by common prefixes)
        # ====================================================
        path {
          path      = "/probestack/v1/apigee/edge"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-profile-config-service"
              port { number = 80 }
            }
          }
        }
        path {
          path      = "/probestack/v1/apigee/x"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-profile-config-service"
              port { number = 80 }
            }
          }
        }
        path {
          path      = "/probestack/v1/cloud-storage/config"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-profile-config-service"
              port { number = 80 }
            }
          }
        }

        # ====================================================
        # 3. APIGEE DISCOVERY SERVICE
        # ====================================================
        path {
          path      = "/probestack/v1/apigee/assetinfo"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-apigee-discovery-service"
              port { number = 80 }
            }
          }
        }
        path {
          path      = "/probestack/v1/apigee/discovery"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-apigee-discovery-service"
              port { number = 80 }
            }
          }
        }

        # ====================================================
        # 4. APIGEE ASSESSMENT SERVICE
        # ====================================================
        path {
          path      = "/probestack/v1/apigee/assessment"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-apigee-assessment-service"
              port { number = 80 }
            }
          }
        }

        # ====================================================
        # 5. APIGEE MIGRATION SERVICE
        # ====================================================
        path {
          path      = "/probestack/v1/apigee/migration"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-apigee-migration-service"
              port { number = 80 }
            }
          }
        }

        # ====================================================
        # 6. APIGEE DEPLOYMENT SERVICE
        # ====================================================
        path {
          path      = "/probestack/v1/apigee/deployments"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-apigee-deployment-service"
              port { number = 80 }
            }
          }
        }
        path {
          path      = "/probestack/v1/apigee/proxies/validate"
          path_type = "Prefix"
          backend {
            service {
              name = "probestack-apigee-deployment-service"
              port { number = 80 }
            }
          }
        }

        # ====================================================
        # 7. APIGEE CUTOVER SERVICE (EXISTING)
        # ====================================================
        path {
          path      = "/probestack/v1/apigee/cutover"
          path_type = "Prefix"
          backend {
            service {
              name = "apigee-cutover"
              port { number = 80 }
            }
          }
        }

        # ====================================================
        # ADMIN BACKEND & UI (EXISTING)
        # ====================================================
        path {
          path      = "/admin-backend"
          path_type = "Prefix"
          backend {
            service {
              name = "admin-backend"
              port { number = 80 }
            }
          }
        }
        path {
          path      = "/admin"
          path_type = "Prefix"
          backend {
            service {
              name = "react-admin"
              port { number = 80 }
            }
          }
        }
      }
    }
  }
}