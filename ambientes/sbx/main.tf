terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source                = "../../modules/vpc"
  region                = var.region
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  single_nat_gateway    = var.single_nat_gateway
  tags                  = var.tags
  project_name         = "ApiLightweight"
}

module "api_gateway_vpc_endpoint" {
  source       = "../../modules/api_gateway_vpc_endpoint"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  project_name = "ApiLightweight"
  tags         = var.tags
}

module "cloudwatch_iam_role" {
  source       = "../../modules/cloudwatch_iam_role"
  project_name = var.project_name
  tags         = var.tags
}

module "api_gateway_rest_private" {
  source = "../../modules/api_gateway_rest_private"

  name              = "api-lightweight-private"
  description       = "API Gateway REST privado para sbx"
  vpc_endpoint_ids  = [module.api_gateway_vpc_endpoint.vpc_endpoint_id]
  stage_name        = "sbx"
  log_group_arn     = module.cloudwatch_logs.log_group_arn  # asumiendo que tienes ese módulo
  region            = var.region
  project_name      = var.project_name
  tags              = var.tags
}

module "cloudwatch_logs" {
  source            = "../../modules/cloudwatch_logs"
  log_group_name = "/aws/api_gateway/ApiLightweight-sbx"
  project_name      = var.project_name
  environment    = "sbx"
  retention_in_days = 14
  tags              = var.tags
}




