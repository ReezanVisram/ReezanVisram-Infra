resource "google_storage_bucket" "reezanvisramportfolio-static-files" {
  name                     = var.cloudstorage_bucket_name
  location                 = var.cloudstorage_bucket_location
  storage_class            = var.cloudstorage_bucket_storage_class
  public_access_prevention = var.cloudstorage_public_access_prevention
}
