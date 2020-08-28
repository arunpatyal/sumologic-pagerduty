# sumologic-pagerduty

The Terraform Template automates the setup of all the necessary resources for collecting Pagerduty product logs.

The Terraform template performs following actions:

* Creation of Sumo Logic collection resources. (Collector, Source)
* Configuration of collection mechanism in Pagerduty.
* Configuration of connections in Sumo Logic to send events from Sumo Logic to other systems.

The Terraform template requires a set of parameters to be configured as defined later in this document.

Follow below instructions to set up the Pagerduty Solution using the Terraform template.

## Requirements

* Terraform 0.12.20+
* curl
* Required Terraform providers (tested on mentioned versions), these providers are automatically installed on terraform init:
    * Sumo Logic Terraform Provider "~> 2.0"
    * Pagerduty Terraform Provider "~> 1.7"
* Access to the Sumo logic console and as a user that is associated with a Sumo Logic role that has the following permissions:
    * Manage Collectors
    * View Collectors
    * Manage connections
    * A Sumo Logic API key and ID created by the above user.
    * Respective access IDs and tokens for Pagerduty with Webhook creation capabilities.

### Step 1: Setup working directory

1. Clone this repository.
2. Install Terraform and make sure it's on your PATH.
3. Initialize the Terraform working directory by running `terraform init`. This will install the required Terraform providers i.e. Sumo Logic Terraform Provider and Pagerduty Terraform Provider.
4. Update the placeholder values in pagerduty.auto.tfvars so they correspond with your Sumo Logic and Pagerduty environments. See the list of input parameters below.

### Step 2: Deploy SDO Solution

To deploy Sumo Logic - SDO Solution, navigate to the directory sumologic-solution-templates/software-development-observability-terraform and execute the below commands:

```
$ terraform plan
$ terraform apply
```

### Uninstalling the solution

To uninstall the solution, navigate to the directory sumologic-solution-templates/software-development-observability-terraform and execute the below command:

```
$ terraform destroy
```

## Pagerduty

[Pagerduty Terraform Provider](https://www.terraform.io/docs/providers/pagerduty/index.html)

Configure these parameters in `pagerduty.auto.tfvars`.

| Parameter | Description | Default|
| --- | --- |
| sumo_access_id            | [Sumo Logic Access ID](https://help.sumologic.com/Manage/Security/Access-Keys)  |       |
| sumo_access_key           | [Sumo Logic Access Key](https://help.sumologic.com/Manage/Security/Access-Keys) |       |
| deployment                | [Sumo Logic Deployment](https://help.sumologic.com/APIs/General-API-Information/Sumo-Logic-Endpoints-and-Firewall-Security)                                                                   | us1   |
| sumo_api_endpoint         | [Sumo Logic API Endpoint](https://help.sumologic.com/APIs/General-API-Information/Sumo-Logic-Endpoints-and-Firewall-Security). Make sure the trailing "/" is present.                    | https://api.sumologic.com/api/v1/  |
| install_pagerduty         | Install [Sumo Logic Application and WebHooks for Pagerduty](https://help.sumologic.com/07Sumo-Logic-Apps/18SAAS_and_Cloud_Apps/PagerDuty_V2)      | true  |
| install_sumo_to_pagerduty_webhook| Install [Sumo Logic to Pagerduty WebHook](https://help.sumologic.com/Manage/Connections-and-Integrations/Webhook-Connections/Webhook-Connection-for-PagerDuty) | true |
| pagerduty_sc         | Source Category for [Pagrduty](https://help.sumologic.com/07Sumo-Logic-Apps/18SAAS_and_Cloud_Apps/PagerDuty_V2)        | Pagerduty  |
| collector_name        | Collector name to be cerated in Sumo Logic | Pagerduty
| pagerduty_api_key        | [Pagerduty API Key](https://support.pagerduty.com/docs/generating-api-keys#section-generating-a-general-access-rest-api-key). ||
| pagerduty_services_pagerduty_webhooks       | List of Pagerduty Service IDs. Example, ["P1QWK8J","PK9FKW3"]. You can get these from the URL after opening a specific service in Pagerduty. These are used for Pagerduty to Sumo Logic webhooks.              ||
| pagerduty_services_sumo_webhooks | Sumo Logic to Pagerduty Webhook. List of Pagerduty Service IDs. Example, ["P1QWK8J","PK9FKW3"]. You can get these from the URL after opening a specific service in Pagerduty. These are used for Sumo Logic to Pagerduty Webhooks.|


