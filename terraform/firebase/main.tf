resource "google_project_service" "firebase_services" {
  for_each = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    "apikeys.googleapis.com",
    "serviceusage.googleapis.com",
    "identitytoolkit.googleapis.com",
    "iap.googleapis.com",
  ])
  service = each.key

  project            = var.project_id
  disable_on_destroy = false
}

resource "google_firebase_project" "firebase_project" {
  provider = google-beta
  project  = var.project_id

  depends_on = [
    google_project_service.firebase_services
  ]
}

resource "google_firebase_web_app" "web_app" {
  provider = google-beta
  project  = var.project_id

  display_name = "CrabyWave Web App"

  deletion_policy = "DELETE"
}


data "google_firebase_web_app_config" "web" {
  provider   = google-beta
  web_app_id = google_firebase_web_app.web_app.app_id
  project    = var.project_id
}

resource "google_firestore_database" "role-service" {
  location_id                       = var.region
  project                           = var.project_id
  name                              = "role-service"
  type                              = "FIRESTORE_NATIVE"
  concurrency_mode                  = "OPTIMISTIC"
  app_engine_integration_mode       = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_DISABLED"
  deletion_policy                   = "DELETE"

  depends_on = [
    google_firebase_project.firebase_project
  ]
}

resource "google_firestore_database" "guild-service" {
  location_id                       = var.region
  project                           = var.project_id
  name                              = "guild-service"
  type                              = "FIRESTORE_NATIVE"
  concurrency_mode                  = "OPTIMISTIC"
  app_engine_integration_mode       = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_DISABLED"
  deletion_policy                   = "DELETE"

  depends_on = [
    google_firebase_project.firebase_project
  ]
}

resource "google_firestore_database" "member-service" {
  location_id                       = var.region
  project                           = var.project_id
  name                              = "member-service"
  type                              = "FIRESTORE_NATIVE"
  concurrency_mode                  = "OPTIMISTIC"
  app_engine_integration_mode       = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_DISABLED"
  deletion_policy                   = "DELETE"

  depends_on = [
    google_firebase_project.firebase_project
  ]
}