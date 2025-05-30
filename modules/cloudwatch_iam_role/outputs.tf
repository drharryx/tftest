output "cloudwatch_role_arn" {
  value = aws_iam_role.apigw_cloudwatch_role.arn
  description = "ARN del rol CloudWatch usado en API Gateway"
}
