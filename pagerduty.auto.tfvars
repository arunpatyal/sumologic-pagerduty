# Sumo Logic - Pagerduty Terraform

# https://help.sumologic.com/Manage/Security/Access-Keys
sumo_access_id  = "<SUMO_ACCESSS_ID>"
sumo_access_key = "<SUMO_ACCESS_KEY>"

# https://help.sumologic.com/APIs/General-API-Information/Sumo-Logic-Endpoints-and-Firewall-Security
deployment = "us1"

# https://help.sumologic.com/APIs/General-API-Information/Sumo-Logic-Endpoints-and-Firewall-Security
sumo_api_endpoint = "https://api.sumologic.com/api/"

install_pagerduty = "true"
collector_name    = "Pagerduty"

# Source Category
pagerduty_sc      = "Pagerduty"

# Configure Pagerduty credentials and parameters.

# https://support.pagerduty.com/docs/generating-api-keys#section-generating-a-general-access-rest-api-key
pagerduty_api_key = "<PAGERDUTY_API_KEY>"

# Pagerduty Service IDs. You can get these from the URL after  opening a specific service. These are used for Pagerduty to Sumo Logic webhooks.
pagerduty_services_pagerduty_webhooks = ["<SERVICE1>", "<SERVICE2>"]

# Sumo Logic to Pagerduty Webhook

install_sumo_to_pagerduty_webhook = "true"

# Pagerduty Service IDs. You can get these from the URL after opening a specific service. These are used for Sumo Logic to Pagerduty webhooks.
pagerduty_services_sumo_webhooks = ["<SERVICE1>", "<SERVICE2>"]