# Sumo Logic - Pagerduty Terraform

# This script creates Webhooks to Sumo Logic in Pagerduty Services.
# Configure the credentials in the pagerduty.auto.tfvars.

# Sumo Logic Provider
provider "sumologic" {
  access_id   = var.sumo_access_id
  access_key  = var.sumo_access_key
  environment = var.deployment
}

# Create/Delete Collector
resource "sumologic_collector" "pagerduty_collector" {
  name     = var.collector_name
  category = var.pagerduty_sc
}

# Create/Delete Pagerduty Source
resource "sumologic_http_source" "pagerduty" {
  count        = "${var.install_pagerduty}" ? 1 : 0
  name         = "Pagerduty"
  category     = var.pagerduty_sc
  collector_id = sumologic_collector.pagerduty_collector.id
}

# Configure the Pagerduty Provider
provider "pagerduty" {
  token = var.pagerduty_api_key
}

data "pagerduty_extension_schema" "webhook" {
  name = "Generic V2 Webhook"
}

# Create Webhook in Pagerduty
resource "pagerduty_extension" "sumologic_extension" {
  count             = "${var.install_pagerduty}" ? length(var.pagerduty_services_pagerduty_webhooks) : 0
  name              = "Sumo Logic Webhook"
  endpoint_url      = sumologic_http_source.pagerduty[0].url
  extension_schema  = data.pagerduty_extension_schema.webhook.id
  extension_objects = [var.pagerduty_services_pagerduty_webhooks[count.index]]
}

data "pagerduty_vendor" "sumologic" {
  name = "Sumo Logic"
}

# We need to create Service Key for each service for Sumo Logic to Pagerduty Webhook
resource "pagerduty_service_integration" "sumologic_service" {
  count   = "${var.install_sumo_to_pagerduty_webhook}" ? length(var.pagerduty_services_sumo_webhooks) : 0
  name    = data.pagerduty_vendor.sumologic.name
  service = var.pagerduty_services_sumo_webhooks[count.index]
  vendor  = data.pagerduty_vendor.sumologic.id
}

# Create/Delete Sumo Logic to Pagerduty Webhook
resource "sumologic_connection" "pagerduty_connection" {
  count       = "${var.install_sumo_to_pagerduty_webhook}" ? length(var.pagerduty_services_sumo_webhooks) : 0
  type        = "WebhookConnection"
  name        = "Pagerduty Connection for Service - ${var.pagerduty_services_sumo_webhooks[count.index]}"
  description = "Created via Sumo Logic Pagerduty Terraform Script."
  url         = "https://events.pagerduty.com/generic/2010-04-15/create_event.json"
  headers = {
    "X-Header" : "Token token=${var.pagerduty_api_key}"
  }

  default_payload = <<JSON
{
	"service_key": "${pagerduty_service_integration.sumologic_service[count.index].integration_key}",
	"event_type": "trigger",
	"description": "Event from Sumo Logic.",
	"client": "Sumo Logic",
	"client_url": "{{SearchQueryUrl}}"
}
JSON
  webhook_type    = "PagerDuty"
}