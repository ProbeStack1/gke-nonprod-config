output "cluster_name" {
  value = google_container_cluster.nonprod.name
}

output "cluster_endpoint" {
  value = google_container_cluster.nonprod.endpoint
}

output "cluster_ca" {
  value = google_container_cluster.nonprod.master_auth[0].cluster_ca_certificate
}
output "cluster_location" {
  value = google_container_cluster.nonprod.location
}
output "gke_nat_ip" {
  value       = google_compute_address.nat_ip.address
  description = "Static Cloud NAT egress IP for GKE"
}