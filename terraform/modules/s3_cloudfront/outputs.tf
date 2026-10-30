output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "Domain name of the CloudFront distribution"
}

output "s3_bucket_id" {
  value       = aws_s3_bucket.frontend.id
  description = "ID of the S3 bucket"
}

output "acm_validation_options" {
  value       = aws_acm_certificate.cert.domain_validation_options
  description = "DNS CNAME records to add to GoDaddy for ACM SSL validation"
}
