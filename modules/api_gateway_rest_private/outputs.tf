output "rest_api_id" {
  description = "ID del API Gateway REST"
  value       = aws_api_gateway_rest_api.this.id
}

output "rest_api_invoke_url" {
  description = "URL para invocar el API Gateway REST"
#  value       = aws_api_gateway_deployment.this.invoke_url
value       = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${var.stage_name}/"
}

output "rest_api_root_resource_id" {
  value = aws_api_gateway_rest_api.this.root_resource_id
}
