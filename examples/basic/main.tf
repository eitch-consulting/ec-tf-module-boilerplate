module "boilerplate_basic" {
  source = "../.."

  project_id = var.project_id
  region     = var.region

  labels = {
    environment = "dev"
    example     = "basic"
  }
}
