provider "google" {
  region      = var.region
  project     = var.project_id
  credentials = file("service-account-credentials.json")
}
