terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

########################################
# Remote state (infra)
########################################

data "terraform_remote_state" "infra" {
  backend = "gcs"

  config = {
    bucket  = "methodical-mark-482504-j3-tf-state-nonprod"
    prefix = "gke-nonprod/infra"
  }
}

########################################
# Google auth (shared)
########################################

data "google_client_config" "default" {}

########################################
# Kubernetes provider (native resources)
########################################

provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.infra.outputs.cluster_endpoint}"
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.infra.outputs.cluster_ca
  )
  token = data.google_client_config.default.access_token
}

########################################
# Kubectl provider (CRDs like BackendConfig)
########################################

provider "kubectl" {
  host                   = "https://${data.terraform_remote_state.infra.outputs.cluster_endpoint}"
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.infra.outputs.cluster_ca
  )
  token = data.google_client_config.default.access_token

  load_config_file = false
}
