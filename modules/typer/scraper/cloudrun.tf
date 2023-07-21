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
        name  = "MYSQL_USERNAME"
        value = var.db_user
      }

      env {
        name = "MYSQL_ROOT_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret.db_password.secret_id
            version = "1"
          }
        }
      }
      env {
        name  = "MYSQL_DATABASE"
        value = var.db_name
      }
      env {
        name  = "MYSQL_UNIX_SOCKET"
        value = "/cloudsql/${var.cloudsql_instance}"
      }
      env {
        name  = "MYSQL_PORT"
        value = var.db_port
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
