variable "cloudrun_instance_name" {
  default = "reezan-visram-com"
}

variable "cloudrun_instance_region" {
  default = "us-central1"
}

variable "cloudrun_min_instance_count" {
  default = 1
}

variable "cloudrun_max_instance_count" {
  default = 4
}

variable "container_base_image" {
  default = "us-central1-docker.pkg.dev/reezan-visram-projects/cloud-run-source-deploy/reezan-visram-com"
}

variable "http_protocol" {
  default = "http1"
}

variable "container_port" {
  default = 80
}
