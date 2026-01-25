resource "mongodbatlas_project_ip_access_list" "gke" {
  project_id = var.atlas_project_id
  ip_address = var.gke_nat_ip
  comment    = "GKE Cloud NAT egress"
}
