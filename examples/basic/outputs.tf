output "project_number" {
  description = "The project number fetched from the module"
  value       = module.boilerplate_basic.project_number
}

output "available_zones" {
  description = "The available zones fetched from the module"
  value       = module.boilerplate_basic.available_zones
}

output "module_labels" {
  description = "The final merged module labels"
  value       = module.boilerplate_basic.module_labels
}
