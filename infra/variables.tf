variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-a"
}
variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "probestack-nonprod"
}
variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "probestacknp-nonprod-vpc"
}
variable "artifact_repo_name" {
  description = "Artifact Registry Docker repository name"
  type        = string
  default     = "probestack-nonprod-apps"
}
variable "router_name" {
  description = "Cloud Router name"
  type        = string
  default     = "probestack-nonprod-router"
}
variable "nat_name" {
  description = "Cloud NAT name"
  type        = string
  default     = "probestack-nonprod-nat"
}
variable "psa_range_name" {
  description = "Private Service Access IP range name"
  type        = string
  default     = "google-service-range"
}
variable "node_pool_name" {
  description = "Primary GKE node pool name"
  type        = string
  default     = "main-pool"
}
variable "subnet_name" {
  description = "GKE subnet name"
  type        = string
  default     = "gke-subnet"
}

variable "cloudsql_tier" {
  description = "Machine tier for Cloud SQL instance"
  type        = string
}

variable "cloudsql_user" {
  description = "MySQL username"
  type        = string
}

variable "cloudsql_password" {
  description = "MySQL user password"
  type        = string
  sensitive   = true
}
variable "dev_domain" {
  description = "Dev environment domain"
  type        = string
}

variable "test_domain" {
  description = "Test environment domain"
  type        = string
}

