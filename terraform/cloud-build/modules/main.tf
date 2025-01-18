locals {
  service_repo = "${var.region}-docker.pkg.dev/${var.project_id}/crabywave/${var.service_name}"
}

resource "google_cloudbuild_trigger" "trigger" {
  name        = "${var.service_name}-trigger-${var.environment}"
  description = "Trigger for ${var.service_name}"
  project     = var.project_id
  location    = var.region

  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
  service_account    = "projects/${var.project_id}/serviceAccounts/nathael-terraform@nathael-dev.iam.gserviceaccount.com"

  github {
    owner = "crabywave-inc"
    name  = var.service_name

    push {
      branch = "^main"
    }
  }

  build {
    timeout = "3600s"

    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build", "-t",
        "${local.service_repo}:$SHORT_SHA",
        "."
      ]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push",
        "${local.service_repo}:$SHORT_SHA",
      ]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "tag",
        "${local.service_repo}:$SHORT_SHA",
        "${local.service_repo}:latest"
      ]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push",
        "${local.service_repo}:latest"
      ]
    }

    options {
      logging     = "CLOUD_LOGGING_ONLY"
      worker_pool = "projects/${var.project_id}/locations/${var.region}/workerPools/cicd-pool"
    }

    images = [
      "${var.region}-docker.pkg.dev/${var.project_id}/crabywave/${var.service_name}:$SHORT_SHA"
    ]
  }
}