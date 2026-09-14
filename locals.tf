locals {
  # Merge user-provided labels with module-specific default labels
  module_labels = merge(
    var.labels,
    {
      managed-by = "terraform"
      module     = "tf-gcp-boilerplate"
    }
  )
}
