output "vpc_endpoint_id" {
  description = "ID del VPC Endpoint Interface para API Gateway REST privado"
  value       = aws_vpc_endpoint.api_gateway_interface.id
}

output "security_group_id" {
  description = "ID del Security Group del VPC Endpoint"
  value       = aws_security_group.api_gateway_endpoint_sg.id
}
