variable "cloudstorage_bucket_name" {
  default = "reezanvisramportfolio-static-files"
}

variable "cloudstorage_bucket_location" {
  default = "us-central1"
}

variable "cloudstorage_bucket_storage_class" {
  default = "REGIONAL"
}

variable "cloudstorage_public_access_prevention" {
  default = "enforced"
}
