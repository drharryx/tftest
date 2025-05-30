variable "vpc_id" {
  description = "ID de la VPC donde se creará el VPC Endpoint"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets para asociar el VPC Endpoint Interface (subnets privadas)"
  type        = list(string)
}

variable "project_name" {
  description = "Nombre del proyecto para los tags"
  type        = string
  default     = "ApiLightweight"
}

variable "tags" {
  description = "Tags adicionales"
  type        = map(string)
  default     = {}
}
