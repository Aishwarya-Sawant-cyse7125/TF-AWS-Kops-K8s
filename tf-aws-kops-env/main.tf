resource "random_string" "randomstr" {
  length           = 16
  special          = false
  upper            = false
}

resource "aws_s3_bucket" "kops_bucket" {
  bucket = "tf-kops-bucket-${random_string.randomstr.result}"
  tags   = {
    Name        = "kops_bucket"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.kops_bucket.id
  acl    = "private"
}