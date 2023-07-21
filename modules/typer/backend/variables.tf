variable "cloudrun_instance_name" {
  default = "typer-backend"
}

variable "cloudrun_instance_region" {
  default = "us-central1"
}

variable "cloudrun_min_instance_count" {
  default = 0
}

variable "cloudrun_max_instance_count" {
  default = 4
}

variable "cloudsql_instance" {
  default = "reezan-visram-projects:us-central1:reezan-visram-projects-cloudsql-instance"
}

variable "container_base_image" {
  default = "us-central1-docker.pkg.dev/reezan-visram-projects/cloud-run-source-deploy/typer-backend"
}

variable "http_protocol" {
  default = "http1"
}

variable "container_port" {
  default = 8080
}

variable "db_user" {
  default = "root"
}

variable "db_name" {
  default = "typer"
}

variable "frontend_url" {
  default = "https://typer.reezanvisram.com"
}
