data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "crabywave-terraform-state"
    prefix = "network"
  }
}