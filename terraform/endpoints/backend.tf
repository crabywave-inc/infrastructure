terraform {
  backend "gcs" {
    bucket = "crabywave-terraform-state"
    prefix = "endpoints"
  }
}