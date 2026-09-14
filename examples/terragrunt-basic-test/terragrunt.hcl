terraform {
  source = "../.."

}

inputs = {
  project_id = get_env("TEST_PROJECT_ID", "ec-gcloud-integrated-tests")
  region     = "us-central1"
}
