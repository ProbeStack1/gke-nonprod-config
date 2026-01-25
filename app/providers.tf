data "terraform_remote_state" "infra" {
  backend = "gcs"
  config = {
    bucket  = "methodical-mark-482504-j3-tf-state-nonprod"
    prefix = "gke-nonprod/infra"
  }
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.infra.outputs.cluster_endpoint}"
  cluster_ca_certificate = base64decode(data.terraform_remote_state.infra.outputs.cluster_ca)
  token                  = data.google_client_config.default.access_token
}

