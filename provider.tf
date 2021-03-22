# Define Terraform provider
terraform {
  required_version = ">= 0.12"
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "0.8.2"
    }
  }
}

# Define the MongoDB Atlas Provider

provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}
