variable "region" {
  description = "Región AWS"
  type        = string
}

variable "bucket_name" {
  description = "Nombre del bucket S3 para el backend remoto"
  type        = string
}

variable "dynamodb_table" {
  description = "Nombre de la tabla DynamoDB para locks"
  type        = string
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
}
