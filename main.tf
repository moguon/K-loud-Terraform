terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}


#VPC 생성
module "vpc" {
  source              = "./modules/vpc"
  name                = "${var.project_name}-vpc"
  vpc_cidr            = "10.0.0.0/16"
  subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
}

# Route53 
module "route53" {
  source                 = "./modules/route53"
  domain_name            = "www.hon9.xyz"
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_zone_id     = "Z2FDTNDATAQYW2" # Default CloudFront Zone ID
}

# ACM
module "acm" {
  source         = "./modules/acm"
  providers = {
  aws = aws.us-east-1
}
  domain_name    = var.domain_name
  route53_zone_id = module.route53.zone_id
  tags           = {
    Project = var.project_name
    }
}

#IAM
module "iam" {
  source       = "./modules/iam"
  role_name    = "lambda_execution_role"
  
  managed_policies = [
    "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}


#CloudFront 생성
module "cloudfront" {
  source = "./modules/cloudfront"
  acm_certificate_arn  = module.acm.certificate_arn
  s3_bucket_name       = "kloud-webpage"
  s3_website_endpoint = "kloud-webpage.s3-website.ap-northeast-2.amazonaws.com"
  api_gateway_1_endpoint = "nglpet7yod.execute-api.ap-northeast-2.amazonaws.com"
  api_gateway_2_endpoint = "1ezekx8bu3.execute-api.ap-northeast-2.amazonaws.com"
  tags           = {
    Project = var.project_name
    }
}
