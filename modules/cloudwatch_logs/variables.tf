variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "retention_in_days" {
  description = "Días de retención de logs"
  type        = number
  default     = 14
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para todos los recursos"
}

variable "log_group_name" {
  type        = string
  description = "Nombre del Log Group de CloudWatch"
}

variable "environment" {
  description = "Nombre del ambiente (por ejemplo: sbx, dev, prod)"
  type        = string
}
