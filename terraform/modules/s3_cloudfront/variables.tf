variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for frontend hosting"
  default     = "crc-frontend-bucket-kiran-2026"
}

variable "domain_name" {
  type        = string
  description = "Custom domain name for the resume site"
  default     = "kiran-cloud.com"
}

variable "acm_certificate_arn" {
  type = string
}
