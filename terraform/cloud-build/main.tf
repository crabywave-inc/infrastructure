resource "google_artifact_registry_repository" "docker_repo" {
  repository_id = "crabywave"
  format        = "DOCKER"
  location      = var.region
  description   = "Docker repository for crabywave"

  labels = {
    project     = "crabywave"
    environment = var.environment
  }
}

locals {
  role_repo = "europe-west1-docker.pkg.dev/${var.project_id}/crabywave/role-service"
}


module "role-service" {
  source = "./modules"

  region      = var.region
  project_id  = var.project_id
  environment = var.environment

  service_name = "role-service"
}

module "auth-service" {
  source = "./modules"

  region      = var.region
  project_id  = var.project_id
  environment = var.environment

  service_name = "auth-service"
}

module "guild-service" {
  source      = "./modules"
  region      = var.region
  project_id  = var.project_id
  environment = var.environment

  service_name = "guild-service"
}

module "member-service" {
  source      = "./modules"
  region      = var.region
  project_id  = var.project_id
  environment = var.environment

  service_name = "member-service"
}


# resource "google_cloudbuild_trigger" "cloudbuild" {
#   name = "role-service-trigger"
#   project = var.project_id
#   description = "Build and deploy role-service"
#   location = var.region

#   tags = [
#     "role-service",
#     "crabywave",
#     var.environment
#   ]


#   include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
#   service_account = "projects/${var.project_id}/serviceAccounts/nathael-terraform@nathael-dev.iam.gserviceaccount.com"

#   github {
#     owner = "crabywave-inc"
#     name  = "role-service"

#     push {
#       branch = "^main"
#     }
#   }


#   build {
#     timeout = "3600s"

#     step {
#       name = "gcr.io/cloud-builders/docker"
#       args = [
#         "build", "-t", 
#         "${local.role_repo}:$SHORT_SHA", 
#         "."
#       ]
#     }

#     step {
#       name = "gcr.io/cloud-builders/docker"
#       args = [
#         "push", 
#         "${local.role_repo}:$SHORT_SHA",
#       ]
#     }

#     step {
#       name = "gcr.io/cloud-builders/docker"
#       args = [ 
#         "tag",
#         "${local.role_repo}:$SHORT_SHA",
#         "${local.role_repo}:latest"
#        ]
#     }

#      step {
#       name = "gcr.io/cloud-builders/docker"
#       args = [
#         "push", 
#         "${local.role_repo}:latest"
#       ]
#     }

#     options {
#       logging = "CLOUD_LOGGING_ONLY"
#       worker_pool = "projects/${var.project_id}/locations/${var.region}/workerPools/cicd-pool"
#     }



#     images = [
#       "europe-west1-docker.pkg.dev/${var.project_id}/crabywave/role-service:$SHORT_SHA"
#     ]
#   }
# }