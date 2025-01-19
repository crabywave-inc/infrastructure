module "role-service" {
  source = "./modules/cloud_run"

  project_id = var.project
  region     = var.region
  env        = var.environment

  image_uri      = "europe-west1-docker.pkg.dev/nathael-dev/crabywave/role-service:latest"
  container_port = 8000
  service_name   = "role-service"

  service_account_roles = [
    "roles/datastore.user",
    "roles/pubsub.editor"
  ]

  environment_variables = {
    AUTH_SERVICE_URL    = "https://auth-service-${var.project_id}.${var.region}.run.app"
    GOOGLE_PROJECT_ID   = var.project
    FIREBASE_DATABASE   = "role-service"
    FIREBASE_PROJECT_ID = "nathael-dev"
  }

  secrets = {}

  vpc_connector = data.terraform_remote_state.network.outputs.run_connector_id
}

module "auth-service" {
  source = "./modules/cloud_run"

  project_id = var.project
  region     = var.region
  env        = var.environment

  image_uri      = "europe-west1-docker.pkg.dev/nathael-dev/crabywave/auth-service:latest"
  container_port = 8000
  service_name   = "auth-service"

  service_account_roles = [
    "roles/firebase.admin",
  ]

  environment_variables = {
    ENV = "production"
  }

  secrets = {
    FIREBASE_API_KEY = "FIREBASE_WEB_API_KEY"
  }

  vpc_connector = data.terraform_remote_state.network.outputs.run_connector_id
}

module "guild-service" {
  source = "./modules/cloud_run"

  project_id = var.project
  region     = var.region
  env        = var.environment

  image_uri      = "europe-west1-docker.pkg.dev/nathael-dev/crabywave/guild-service:latest"
  container_port = 8000
  service_name   = "guild-service"

  service_account_roles = [
    "roles/datastore.user",
    "roles/pubsub.editor"
  ]

  environment_variables = {
    ENV                 = "production"
    AUTH_SERVICE_URL    = "https://auth-service-${var.project_id}.${var.region}.run.app"
    GOOGLE_PROJECT_ID   = var.project
    FIREBASE_DATABASE   = "guild-service"
    FIREBASE_PROJECT_ID = "nathael-dev"
  }

  secrets = {}

  vpc_connector = data.terraform_remote_state.network.outputs.run_connector_id
}

module "member-service" {
  source = "./modules/cloud_run"

  project_id = var.project
  region     = var.region
  env        = var.environment

  image_uri      = "europe-west1-docker.pkg.dev/nathael-dev/crabywave/member-service:latest"
  container_port = 8000
  service_name   = "member-service"

  service_account_roles = [
    "roles/datastore.user",
    "roles/pubsub.editor"
  ]

  environment_variables = {
    ENV                 = "production"
    AUTH_SERVICE_URL    = "https://auth-service-${var.project_id}.${var.region}.run.app"
    GOOGLE_PROJECT_ID   = var.project
    FIREBASE_DATABASE   = "member-service"
    FIREBASE_PROJECT_ID = "nathael-dev"
  }

  secrets = {}

  vpc_connector = data.terraform_remote_state.network.outputs.run_connector_id
}