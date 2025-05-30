variable "bucket_name" {
  description = "Nombre del bucket S3 para el estado remoto"
  type        = string
}

variable "dynamodb_table" {
  description = "Nombre de la tabla DynamoDB para los locks"
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes para los recursos"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "Región AWS"
  type        = string
}