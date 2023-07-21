variable "cloudrun_instance_name" {
  default = "typer-frontend"
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
  default = "us-central1-docker.pkg.dev/reezan-visram-projects/cloud-run-source-deploy/typer-frontend"
}

variable "http_protocol" {
  default = "http1"
}

variable "container_port" {
  default = 80
}

variable "backend_url" {
  default = "https://api.typer.reezanvisram.com"
}

variable "frontend_url" {
  default = "https://typer.reezanvisram.com"
}

variable "session_cookie_name" {
  default = "typer-cookie"
}
