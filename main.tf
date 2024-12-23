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
  subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
}

# ALB 생성
module "alb" {
  source             = "./modules/alb"
  name               = "${var.project_name}-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [aws_security_group.alb_sg.id]

}

# Route53 
module "route53" {
  source                 = "./modules/route53"
  domain_name            = "hon9.xyz"
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_zone_id     = "Z2FDTNDATAQYW2" # Default CloudFront Zone ID
}

# ACM
module "acm" {
  source         = "./modules/acm"
  domain_name    = var.domain_name
  route53_zone_id = module.route53.zone_id
  tags           = {
    Project = var.project_name
    }
}

#IAM
module "iam" {
  source = "./modules/iam"

  project_name   = var.project_name
  s3_bucket_arn  = "arn:aws:s3:::kloud-webpage" 
}

#CloudFront 생성
module "cloudfront" {
  source = "./modules/cloudfront"
  acm_certificate_arn  = module.acm.certificate_arn
  s3_bucket_name       = "kloud-webpage"
  s3_website_endpoint = "kloud-webpage.s3-website.ap-northeast-2.amazonaws.com"
  api_gateway_1_endpoint = "nglpet7yod.execute-api.ap-northeast-2.amazonaws.com"
  # api_gateway_2_endpoint = "1ezekx8bu3.execute-api.ap-northeast-2.amazonaws.com"
  tags           = {
    Project = var.project_name
    }
}



# # WAF (웹 방화벽) 생성
# module "waf" {
#   source = "./modules/waf"
#   name   = "${var.project_name}-waf"
# }

