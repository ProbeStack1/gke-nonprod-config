output "mongodb_uri" {
  value     = data.mongodbatlas_cluster.existing.srv_address
  sensitive = true
}

