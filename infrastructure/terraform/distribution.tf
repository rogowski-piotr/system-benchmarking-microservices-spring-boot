# origin access identity for distribution
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
comment = "cloudfront distribution identity"
}

# distribution
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    # this is the domain name of s3 bucket which we created
    domain_name = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    # here we are using that s3 origin id 
    origin_id   = local.s3_origin_id

    s3_origin_config {
  origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "cloudfront for static content"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    # here we are defining to redirect http trafic to https
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # we are defining geo_restriction as none 
  # this is a very useful attribute,it can be use when we have to block content on certain geo graphical region
  # we can blacklist or whitelist locations
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}