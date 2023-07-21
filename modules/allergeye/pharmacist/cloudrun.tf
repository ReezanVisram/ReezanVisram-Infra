resource "google_cloud_run_v2_service" "default" {
  name     = var.cloudrun_instance_name
  location = var.cloudrun_instance_region
  ingress  = "INGRESS_TRAFFIC_ALL"
  template {
    scaling {
      min_instance_count = var.cloudrun_min_instance_count
      max_instance_count = var.cloudrun_max_instance_count
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.cloudsql_instance]
      }
    }

    containers {
      image = var.container_base_image

      ports {
        name           = var.http_protocol
        container_port = var.container_port
      }

      env {
        name  = "DB_USER"
        value = var.db_user
      }

      env {
        name = "DB_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret.db_password.secret_id
            version = "1"
          }
        }
      }
      env {
        name  = "DB_DATABASE"
        value = var.db_name
      }
      env {
        name  = "DB_UNIX_SOCKET"
        value = "/cloudsql/${var.cloudsql_instance}"
      }
      env {
        name = "JWT_SECRET"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret.jwt_secret_key.secret_id
            version = "1"
          }
        }
      }
      env {
        name  = "ENVIRONMENT"
        value = "prod"
      }

      volume_mounts {
        mount_path = "/cloudsql"
        name       = "cloudsql"
      }

    }
  }
}

data "google_secret_manager_secret" "db_password" {
  secret_id = "CLOUDSQL_PASSWORD"
}

data "google_secret_manager_secret" "jwt_secret_key" {
  secret_id = "JWT_SECRET_KEY"
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  project     = google_cloud_run_v2_service.default.project
  location    = google_cloud_run_v2_service.default.location
  name        = google_cloud_run_v2_service.default.name
  policy_data = data.google_iam_policy.admin.policy_data
}
