variable "cloudrun_instance_name" {
  default = "surveyor-service"
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
  default = "us-central1-docker.pkg.dev/reezan-visram-projects/allergeye/surveyor-service"
}

variable "http_protocol" {
  default = "h2c"
}

variable "container_port" {
  default = 8080
}
