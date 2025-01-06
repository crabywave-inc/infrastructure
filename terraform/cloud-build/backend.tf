terraform {
  backend "gcs" {
    bucket = "crabywave-terraform-state"
    prefix = "cloud-build"
  }
}