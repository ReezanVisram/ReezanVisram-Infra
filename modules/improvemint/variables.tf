variable "cloudrun_instance_name" {
  default = "improvemint"
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

variable "http_protocol" {
  default = "http1"
}

variable "container_port" {
  default = 8080
}
