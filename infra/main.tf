variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.s3_bucket_name


  tags = {
    Name        = var.s3_bucket_name
    Environment = "DevOps-Kickstart"
  }
}
