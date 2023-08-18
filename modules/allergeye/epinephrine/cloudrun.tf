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
        name  = "PHARMACIST_SERVICE_URL"
        value = "pharmacist-service-bbgxeko6ga-uc.a.run.app"
      }

      env {
        name  = "SURVEYOR_SERVICE_URL"
        value = "https://surveyor-service-bbgxeko6ga-uc.a.run.app"
      }
    }
  }
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
