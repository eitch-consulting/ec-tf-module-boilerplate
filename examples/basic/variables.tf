variable "project_id" {
  description = "The Google Cloud project ID to test with"
  type        = string
  default     = "ec-gcloud-integrated-tests"
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}
