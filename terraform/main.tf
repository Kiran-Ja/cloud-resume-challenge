terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "CloudResumeChallenge"
      ManagedBy = "Terraform"
    }
  }
}

module "backend" {
  source = "./modules/api_lambda_dynamo"
}

output "api_url" {
  value = module.backend.api_endpoint
}

module "frontend" {
  source              = "./modules/s3_cloudfront"
  acm_certificate_arn = "arn:aws:acm:us-east-1:883218392715:certificate/3bfd2732-4075-4faf-af58-a282278e56c9"
}

output "cloudfront_url" {
  value = module.frontend.cloudfront_domain_name
}

output "acm_dns_validation" {
  value = module.frontend.acm_validation_options
}
