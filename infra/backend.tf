terraform {
  backend "gcs" {
    bucket  = "methodical-mark-482504-j3-tf-state-nonprod"
    prefix  = "gke-nonprod/infra"
  }
}
