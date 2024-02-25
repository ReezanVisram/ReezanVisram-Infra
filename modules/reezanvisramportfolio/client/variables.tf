variable "cloudrun_instance_name" {
  default = "reezanvisramportfolio-client"
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

variable "container_base_image" {
  default = "us-central1-docker.pkg.dev/reezan-visram-projects/reezanvisramportfolio/reezanvisramportfolio-client:latest"
}

variable "http_protocol" {
  default = "http1"
}

variable "container_port" {
  default = 3000
}
