resource "google_container_node_pool" "main" {
  name     = var.node_pool_name
  cluster  = google_container_cluster.nonprod.name
  location = var.zone

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = "e2-custom-2-10240"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
