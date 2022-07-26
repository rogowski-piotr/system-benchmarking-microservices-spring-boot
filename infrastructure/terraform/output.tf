# instance ip
output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}

# distribution id
output "distribution_domain" {
  value = aws_cloudfront_distribution.distribution.domain_name
}