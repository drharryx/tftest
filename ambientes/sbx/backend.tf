terraform {
  backend "s3" {
    bucket         = "mi-bucket-tf-state-api"
    key            = "sbx/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
