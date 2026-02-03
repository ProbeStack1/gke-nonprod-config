variable "react_vite_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/react-vite:1.0"
}
variable "react_admin_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/react-admin:11.0"
}
variable "admin_backend_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/admin-backend:3.0"
}
variable "apigee_cutover_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/cutover:1.0"
}
variable "apigee_edge_mock_service_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/apigee-edge-mock-service:1.0"
}
variable "probestack_apigee_assessment_service_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/probestack-apigee-assessment-service:1.0"
}
variable "probestack_apigee_deployment_service_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/probestack-apigee-deployments-service:1.0"
}
variable "probestack_apigee_discovery_service_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/probestack-apigee-discovery-service:1.0"
}
variable "probestack_apigee_migration_service_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/probestack-apigee-migration-service:1.0"
}
variable "probestack_profile_config_service_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/methodical-mark-482504-j3/probestack-nonprod-apps/probestack-profile-config-service:1.0"
}
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "cloudsql_tier" {
  description = "Cloud SQL instance tier"
  type        = string
}

variable "cloudsql_user" {
  description = "Cloud SQL DB user"
  type        = string
}

variable "cloudsql_password" {
  description = "Cloud SQL DB password"
  type        = string
  sensitive   = true
}

variable "dev_domain" {
  description = "Dev domain"
  type        = string
}

variable "test_domain" {
  description = "Test domain"
  type        = string
}
variable "mongodb_uri" {
  sensitive = true
}




