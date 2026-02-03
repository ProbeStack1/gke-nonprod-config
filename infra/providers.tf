terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

########################################
# Google Provider
########################################

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

########################################
# Data Sources
########################################

data "google_client_config" "default" {}

data "google_container_cluster" "nonprod" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.zone
}

########################################
# Kubernetes Provider (native resources)
########################################

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.nonprod.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.nonprod.master_auth[0].cluster_ca_certificate
  )
}

########################################
# Kubectl Provider (CRDs like BackendConfig)
########################################

provider "kubectl" {
  host                   = "https://${data.google_container_cluster.nonprod.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.nonprod.master_auth[0].cluster_ca_certificate
  )

  load_config_file = false
}
