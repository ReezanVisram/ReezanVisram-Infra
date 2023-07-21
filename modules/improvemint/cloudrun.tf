resource "google_cloud_run_v2_service" "default" {
  name     = var.cloudrun_instance_name
  location = "us-central1"

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
      image = "us-central1-docker.pkg.dev/reezan-visram-projects/cloud-run-source-deploy/improvemint"

      ports {
        name           = var.http_protocol
        container_port = var.container_port
      }

      env {
        name  = "ENV"
        value = "prod"
      }

      volume_mounts {
        mount_path = "/cloudsql"
        name       = "cloudsql"
      }
    }
  }
}
