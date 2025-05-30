provider "aws" {
  region = var.region
}

module "remote_state" {
  source          = "../modules/remote_state"
  bucket_name     = var.bucket_name
  dynamodb_table  = var.dynamodb_table
  tags            = var.tags
  region          = var.region   # <-- esta línea
}

