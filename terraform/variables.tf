variable "aws_region" {
  type        = string
  description = "AWS region for infrastructure deployment"
  default     = "ap-northeast-1"
}

variable "domain_name" {
  type        = string
  description = "Custom domain name for the cloud resume"
  default     = "yourdomain.com"
}
