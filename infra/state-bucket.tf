resource "google_storage_bucket" "tf_state" {
  name          = "methodical-mark-482504-j3-tf-state-nonprod"
  location      = "US"
  force_destroy = false

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
