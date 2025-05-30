variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para las subredes"
  type        = list(string)
}

variable "single_nat_gateway" {
  type = bool
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "bucket_name" {
  type = string
}

variable "dynamodb_table" {
  type = string
}

variable "project_name" {
  description = "Nombre del proyecto para tags"
  type        = string
  default     = "ApiLightweight"
}