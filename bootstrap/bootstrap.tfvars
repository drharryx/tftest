region         = "us-east-1"
bucket_name    = "mi-bucket-tf-state-api"
dynamodb_table = "terraform-locks"

tags = {
  Project     = "Api_Lightweight"
  Environment = "global"
}

