variable "name" {
  description = "Nombre del API Gateway"
  type        = string
}

variable "description" {
  description = "Descripción del API Gateway"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}

variable "vpc_endpoint_ids" {
  description = "Lista de IDs de VPC Endpoint para Private API Gateway"
  type        = list(string)
}

variable "stage_name" {
  description = "Nombre de la etapa (stage) del API Gateway"
  type        = string
  default     = "sbx"
}

variable "project_name" {
  description = "Nombre del proyecto para tags"
  type        = string
  default     = "ApiLightweight"
}

variable "region" {
  type        = string
  description = "Región AWS us-east-1"
}

variable "log_group_arn" {
  type        = string
  description = "ARN del CloudWatch Log Group para integración con API Gateway"
  default     = ""
}

