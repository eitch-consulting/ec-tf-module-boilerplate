output "project_number" {
  description = "The numeric project ID fetched from the data source"
  value       = data.google_project.current.number
}

output "available_zones" {
  description = "A list of available compute zones in the specified region"
  value       = data.google_compute_zones.available.names
}

output "module_labels" {
  description = "The final merged labels that will be applied to resources"
  value       = local.module_labels
}
