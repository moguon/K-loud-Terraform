terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

# VPC 생성
module "vpc" {
  source              = "./modules/vpc"
  name                = "${var.project_name}-vpc"
  vpc_cidr            = "10.0.0.0/16"
  subnet_cidrs        = ["10.0.0.0/24", "10.0.1.0/24"]
  availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
  allow_inbound_cidr  = "10.0.0.0/16"
  allow_outbound_cidr = "0.0.0.0/0"
}

resource "aws_security_group" "vpc_endpoint_sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  tags = {
    Name = "${var.project_name}-endpoint-sg"
  }
}
// ---
// Create the VPC Endpoint for s3
// ---
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id        = module.vpc.vpc_id
  service_name  = "com.amazonaws.ap-northeast-2.s3"
  vpc_endpoint_type   = "Gateway"
  route_table_ids = module.vpc.route_table_ids
  tags = {
    Name = "${var.project_name}-s3-endpoint"
  }
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-2.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.vpc.route_table_ids
  tags = {
    Name = "${var.project_name}-dynamodb-endpoint"
  }
}

resource "aws_vpc_endpoint" "api_gateway_endpoint" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-northeast-2.execute-api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true
  tags = {
    Name = "${var.project_name}-api-gateway-endpoint"
  }
}


# # S3 Bucket 생성
# module "s3" {
#   source      = "./modules/s3"
#   bucket_name = "${var.project_name}-bucket"
#   tags = {
#     Project = var.project_name
#   }
# }

# # DynamoDB 생성
# module "dynamodb" {
#   source      = "./modules/dynamodb"
#   table_name  = "${var.project_name}-table"
#   tags = {
#     Project = var.project_name
#   }
# }

# # Lambda 함수 생성
# module "lambda" {
#   source        = "./modules/lambda"
#   function_name = "${var.project_name}-lambda"
#   code_path     = "lambda/function.zip"
# }

# # API Gateway 생성
# module "api-gateway" {
#   source      = "./modules/api-gateway"
#   stage       = "prod"
#   domain_name = "api.${var.project_name}.com"
# }

# # CloudFront 생성
# module "cloudfront" {
#   source      = "./modules/cloudfront"
#   domain_name = "cdn.${var.project_name}.com"
# }

# # WAF (웹 방화벽) 생성
# module "waf" {
#   source = "./modules/waf"
#   name   = "${var.project_name}-waf"
# }

# # IAM 역할 생성
# module "iam" {
#   source = "./modules/iam"
#   name   = "${var.project_name}-iam-role"
# }
