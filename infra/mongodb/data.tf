data "mongodbatlas_cluster" "existing" {
  project_id = var.atlas_project_id
  name       = var.atlas_cluster_name
}
