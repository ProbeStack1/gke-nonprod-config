resource "google_sql_database_instance" "mysql" {
  name             = "probestack-mysql-nonprod"
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = var.cloudsql_tier

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }

    availability_type = "ZONAL"
  }

  deletion_protection = false
}

# DEV database
resource "google_sql_database" "admin_dev" {
  name     = "probestack-admin-dev"
  instance = google_sql_database_instance.mysql.name
}

# TEST database
resource "google_sql_database" "admin_test" {
  name     = "probestack-admin-test"
  instance = google_sql_database_instance.mysql.name
}

# MySQL user
resource "google_sql_user" "admin" {
  name     = var.cloudsql_user
  password = var.cloudsql_password
  instance = google_sql_database_instance.mysql.name
}