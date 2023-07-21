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
        name  = "REACT_APP_BACKEND_URL"
        value = var.backend_url
      }

      env {
        name  = "REACT_APP_FRONTEND_URL"
        value = var.frontend_url
      }

      env {
        name  = "REACT_APP_SESSION_COOKIE_NAME"
        value = var.session_cookie_name
      }

      env {
        name  = "BACKEND_URL"
        value = var.backend_url
      }

      volume_mounts {
        mount_path = "/cloudsql"
        name       = "cloudsql"
      }

    }
  }
}
