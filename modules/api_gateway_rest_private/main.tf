data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api" "this" {
  name = var.project_name
  description = var.description
  endpoint_configuration {
    types = ["PRIVATE"]
    vpc_endpoint_ids = var.vpc_endpoint_ids
  }
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "execute-api:Invoke"
      Resource  = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.name}/*/*/*"
    }]
  })

  tags = var.tags
}

resource "aws_api_gateway_resource" "root_resource" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.root_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.root_resource.id
  http_method = aws_api_gateway_method.get_method.http_method
  type        = "MOCK"
  integration_http_method = "GET"
}

resource "aws_api_gateway_deployment" "this" {
  depends_on  = [aws_api_gateway_integration.get_integration]
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name
  deployment_id = aws_api_gateway_deployment.this.id

  dynamic "access_log_settings" {
    for_each = var.log_group_arn != "" ? [1] : []

    content {
      destination_arn = var.log_group_arn
      format = jsonencode({
        requestId      = "$context.requestId"
        ip             = "$context.identity.sourceIp"
        caller         = "$context.identity.caller"
        user           = "$context.identity.user"
        requestTime    = "$context.requestTime"
        httpMethod     = "$context.httpMethod"
        resourcePath   = "$context.resourcePath"
        status         = "$context.status"
        protocol       = "$context.protocol"
        responseLength = "$context.responseLength"
      })
    }
  }

  tags = merge(var.tags, {
    Name    = "${var.project_name}-${var.name}-stage"
    Project = var.project_name
  })
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"  # <- Esto es lo que faltaba

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
    data_trace_enabled = true
  }
}
