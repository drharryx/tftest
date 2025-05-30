output "log_group_name" {
  description = "Nombre del Log Group"
  value       = aws_cloudwatch_log_group.api_gw_logs.name
}

output "cloudwatch_policy_arn" {
  description = "ARN de la política de CloudWatch para API Gateway"
  value       = aws_iam_policy.api_gateway_cloudwatch_policy.arn
}

output "log_group_arn" {
  description = "ARN del Log Group para API Gateway"
  value       = aws_cloudwatch_log_group.api_gw_logs.arn
}


