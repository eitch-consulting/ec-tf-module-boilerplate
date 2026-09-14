variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "The project_id must be 6-30 characters, begin with a letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.region))
    error_message = "The region must be a valid Google Cloud region name (e.g., us-central1)."
  }
}

variable "labels" {
  description = "A map of key/value label pairs to assign to resources created by this module"
  type        = map(string)
  default     = {}
}
