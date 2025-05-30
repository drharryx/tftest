resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = "/aws/apigateway/${var.project_name}-${var.environment}"
  retention_in_days = var.retention_in_days

  tags = merge({
    Project = var.project_name
    Name    = "${var.project_name}-${var.environment}-log-group"
  }, var.tags)
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

resource "aws_iam_policy" "api_gateway_cloudwatch_policy" {
  name        = "${var.project_name}-api-gateway-cloudwatch-policy"
  description = "Permite a API Gateway escribir en CloudWatch Logs"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = aws_cloudwatch_log_group.this.arn
      }
    ]
  })
}
