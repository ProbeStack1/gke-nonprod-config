resource "mongodbatlas_database_user" "app" {
  project_id         = var.atlas_project_id
  username           = "java-app"
  password           = var.mongodb_password
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "appdb"
  }
}
