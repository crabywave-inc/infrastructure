resource "google_pubsub_topic" "pubsub_topics" {
  for_each = toset(var.topics)

  labels = {
    environment = var.environment
  }
  name    = each.key
  project = var.project_id
}

resource "google_pubsub_subscription" "pubsub_subscriptions" {
  for_each = var.subscriptions

  name    = each.key
  topic   = google_pubsub_topic.pubsub_topics[each.value.topic_name].name
  project = var.project_id
  labels = {
    environment = var.environment
  }

  ack_deadline_seconds       = tonumber(each.value.ack_deadline_seconds)
  retain_acked_messages      = true
  message_retention_duration = each.value.retention_duration
  enable_message_ordering    = each.value.message_ordering

  expiration_policy {
    ttl = each.value.expiration_policy
  }
}
