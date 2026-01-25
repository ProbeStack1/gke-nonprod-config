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
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

data "google_client_config" "default" {}

data "google_container_cluster" "nonprod" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.zone
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.nonprod.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.nonprod.master_auth[0].cluster_ca_certificate
  )
}