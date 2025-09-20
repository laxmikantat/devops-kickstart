resource "aws_s3_bucket" "app_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "DevOps-Kickstart-Bucket"
    Environment = "Dev"
  }
}
