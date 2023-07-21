resource "google_cloud_run_v2_service" "default" {
  name     = var.cloudrun_instance_name
  location = var.cloudrun_instance_region

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

resource "google_artifact_registry_repository" "cloudrun_source_deploy_repository" {
  location      = var.cloudrun_instance_region
  repository_id = "cloud-run-source-deploy"
  format        = "DOCKER"
  description   = "Cloud Run Source Deployments"
}
