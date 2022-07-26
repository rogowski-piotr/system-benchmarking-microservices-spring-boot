# this resource will create a s3 bucket with name webserver-static
# this bucket will contain all our website static files
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "webserver-static"
  acl    = "private"

  tags = {
    Name = "static files bucket"
  }
}

# here we are blocking all the public access to this bucket,
# we are blocking public access so no can directly access object of bucket,
# we want object to be accesed via cloudFront distribution
resource "aws_s3_bucket_public_access_block" "s3_block_access" {
  bucket = aws_s3_bucket.s3_bucket.id
  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}

# this will create a s3 origin id which will be used in cloudFront to set origin as s3 bucket 
locals {
  s3_origin_id = "s3Origin"
}