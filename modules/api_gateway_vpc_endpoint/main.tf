resource "aws_security_group" "api_gateway_endpoint_sg" {
  name        = "${var.project_name}-api-gateway-endpoint-sg"
  description = "Security Group para VPC Endpoint Interface de API Gateway REST"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Ajusta este rango según tu red, puede ser un input variable si quieres
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Igual que arriba o variable para personalizar
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Project = var.project_name
    Name    = "${var.project_name}-api-gateway-endpoint-sg"
  }, var.tags)
}

resource "aws_vpc_endpoint" "api_gateway_interface" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.execute-api" # Endpoint para API Gateway REST
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [aws_security_group.api_gateway_endpoint_sg.id]

  private_dns_enabled = true

  tags = merge({
    Project = var.project_name
    Name    = "${var.project_name}-api-gateway-endpoint"
  }, var.tags)
}

data "aws_region" "current" {}
