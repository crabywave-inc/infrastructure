resource "google_secret_manager_secret" "firebase_web_api_key" {
  project   = var.project_id
  secret_id = "FIREBASE_WEB_API_KEY-${upper(var.environment)}"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "firebase_web_api_key" {
  secret      = google_secret_manager_secret.firebase_web_api_key.id
  secret_data = data.google_firebase_web_app_config.web.api_key
}