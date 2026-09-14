# Eitch Consulting Terraform Module Boilerplate

A starter template for developing Google Cloud Platform (GCP) Terraform modules at Eitch Consulting.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.5.0 |
| google | >= 8.0 |
| google-beta | >= 8.0 |

## Providers

| Name | Version |
| ---- | ------- |
| google | 8.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| labels | A map of key/value label pairs to assign to resources created by this module | `map(string)` | `{}` | no |
| project\_id | The Google Cloud project ID | `string` | n/a | yes |
| region | The Google Cloud region | `string` | `"us-central1"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| available\_zones | A list of available compute zones in the specified region |
| module\_labels | The final merged labels that will be applied to resources |
| project\_number | The numeric project ID fetched from the data source |
<!-- END_TF_DOCS -->
