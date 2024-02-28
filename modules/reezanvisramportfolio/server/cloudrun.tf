resource "google_cloud_run_v2_service" "default" {
  name     = var.cloudrun_instance_name
  location = var.cloudrun_instance_region

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
        name = "WEBHOOK_SECRET"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret.webhook_secret.secret_id
            version = "1"
          }
        }
      }

      env {
        name  = "MONGODB_CONNECTION_METHOD"
        value = "mongodb+srv"
      }

      env {
        name  = "MONGODB_USERNAME"
        value = "reezanvisramportfolio"
      }

      env {
        name = "MONGODB_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret.mongodb_password.secret_id
            version = "1"
          }
        }
      }

      env {
        name  = "MONGODB_HOST"
        value = "reezanvisramprojects.bjda0jc.mongodb.net"
      }

      env {
        name  = "MONGODB_DATABASE"
        value = "reezanvisramportfolio"
      }

      env {
        name  = "MONGODB_CONNECTION_OPTIONS"
        value = "?retryWrites=true&w=majority"
      }

      env {
        name  = "CLOUDSTORAGE_BUCKET_NAME"
        value = "reezanvisramportfolio-static-files"
      }

      env {
        name  = "CLOUDSTORAGE_FILENAME_TO_FETCH"
        value = "resume.pdf"
      }

      env {
        name = "RECAPTCHA_SECRET"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret.recaptcha_secret.secret_id
            version = "1"
          }
        }
      }
    }
  }
}


data "google_secret_manager_secret" "mongodb_password" {
  secret_id = "REEZAN_VISRAM_PORTFOLIO_MONGO_PASSWORD"
}

data "google_secret_manager_secret" "webhook_secret" {
  secret_id = "REEZAN_VISRAM_PORTFOLIO_WEBHOOK_SECRET"
}

data "google_secret_manager_secret" "recaptcha_secret" {
  secret_id = "REEZAN_VISRAM_PORTFOLIO_RECAPTCHA_SECRET"
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  project     = google_cloud_run_v2_service.default.project
  location    = google_cloud_run_v2_service.default.location
  name        = google_cloud_run_v2_service.default.name
  policy_data = data.google_iam_policy.admin.policy_data
}

