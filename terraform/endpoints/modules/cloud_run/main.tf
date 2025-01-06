resource "google_service_account" "service_account" {
  account_id = "${var.service_name}-account"
  display_name = "${var.service_name} Account"
  project = var.project_id
}

resource "google_project_iam_member" "service_account_secret_access" {
  
  project = var.project_id
  role = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "dynamic_roles" {
  for_each = toset(var.service_account_roles)

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_secret_manager_secret" "cloud_run_url_secret" {
  secret_id = "${upper(var.service_name)}_URL-${upper(var.env)}"

  labels = {
    env = var.env
  }

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_cloud_run_service" "cloud_run" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image_uri
        ports {
          container_port = var.container_port
        }

        dynamic "env" {
          for_each = var.environment_variables

          content {
            name  = env.key
            value = env.value
          }
        }

        dynamic "env" {
          for_each = var.secrets

          content {
            name = env.key

            value_from {
              secret_key_ref {
                name = "${env.value}-${upper(var.env)}"
                key  = "latest"
              }
            }
          }
        }
      }



      service_account_name = google_service_account.service_account.email
    }

    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
      }
    }
  }


  traffic {
    percent         = 100
    latest_revision = true
  }

  # Autoriser les requêtes publiques
  autogenerate_revision_name = true

  depends_on = [
    google_service_account.service_account,
    google_project_iam_member.service_account_secret_access
  ]
}

resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.cloud_run.name
  location = google_cloud_run_service.cloud_run.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_secret_manager_secret_version" "cloud_run_url_version" {
  secret      = google_secret_manager_secret.cloud_run_url_secret.name
  secret_data = google_cloud_run_service.cloud_run.status[0].url
}
