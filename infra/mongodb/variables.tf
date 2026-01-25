variable "atlas_project_id" {
  description = "MongoDB Atlas Project ID"
}

variable "atlas_public_key" {
  description = "MongoDB Atlas API public key"
  sensitive   = true
}

variable "atlas_private_key" {
  description = "MongoDB Atlas API private key"
  sensitive   = true
}

variable "atlas_cluster_name" {
  description = "Existing MongoDB Atlas cluster name"
}

variable "gke_nat_ip" {
  description = "Static Cloud NAT egress IP of GKE"
}

variable "mongodb_password" {
  description = "Password for MongoDB application user"
  sensitive   = true
}


