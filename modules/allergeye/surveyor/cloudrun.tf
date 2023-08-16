resource "google_cloud_run_v2_service" "default" {
  name     = var.cloudrun_instance_name
  location = var.cloudrun_instance_region
  ingress  = "INGRESS_TRAFFIC_ALL"
  template {
    scaling {
      min_instance_count = var.cloudrun_min_instance_count
      max_instance_count = var.cloudrun_max_instance_count
    }

    containers {
      image = var.container_base_image

      ports {
        name           = var.http_protocol
        container_port = var.container_port
      }

      env {
        name  = "ENV"
        value = "prod"
      }

      env {
        name  = "DB_CONN_METHOD"
        value = "mongodb+srv"
      }

      env {
        name  = "DB_USER"
        value = "reezanvisram"
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
        name  = "DB_HOST"
        value = "reezanvisramprojects.bjda0jc.mongodb.net"
      }

      env {
        name  = "DB_CONN_OPTIONS"
        value = "retryWrites=true&w=majority"
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
    }
  }
}

data "google_secret_manager_secret" "db_password" {
  secret_id = "MONGO_PASSWORD"
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
