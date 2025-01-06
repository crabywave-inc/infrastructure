terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.12.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "google" {
  project         = var.project_id
  region          = var.region
  billing_project = var.project_id
  //credentials     = "../creds.json"
}

provider "google-beta" {
  project         = var.project_id
  region          = var.region
  billing_project = var.project_id
  //credentials     = "../creds.json"
}