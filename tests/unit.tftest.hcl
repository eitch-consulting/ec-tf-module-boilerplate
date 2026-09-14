# Mock GCP providers for offline/credential-free unit testing
mock_provider "google" {}
mock_provider "google-beta" {}

variables {
  project_id = "ec-gcloud-integration-tests"
  region     = "us-central1"
  labels = {
    env = "testing"
  }
}

run "valid_inputs_and_labels" {
  command = plan

  assert {
    condition     = local.module_labels["managed-by"] == "terraform"
    error_message = "Default managed-by label was not set"
  }

  assert {
    condition     = local.module_labels["module"] == "tf-gcp-boilerplate"
    error_message = "Default module label was not set"
  }

  assert {
    condition     = local.module_labels["env"] == "testing"
    error_message = "User-provided label was not preserved"
  }
}

run "invalid_project_id_validation" {
  command = plan

  variables {
    project_id = "INVALID_PROJECT_ID"
  }

  expect_failures = [
    var.project_id
  ]
}

run "invalid_region_validation" {
  command = plan

  variables {
    region = "invalid_region"
  }

  expect_failures = [
    var.region
  ]
}

run "invalid_label_key_validation" {
  command = plan

  variables {
    labels = {
      "Invalid_Key" = "value"
    }
  }

  expect_failures = [
    var.labels
  ]
}

run "invalid_label_value_validation" {
  command = plan

  variables {
    labels = {
      "valid_key" = "INVALID VALUE WITH SPACES!"
    }
  }

  expect_failures = [
    var.labels
  ]
}
