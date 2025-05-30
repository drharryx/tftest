variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "AZs for the subnets"
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "If true, only one NAT Gateway will be created"
  type        = bool
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetas y nombres"
  type        = string
}

