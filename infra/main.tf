# Generate a random suffix for uniqueness
resource "random_id" "suffix" {
  byte_length = 4
}

# Create S3 bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = "devops-kickstart-bucket-${random_id.suffix.hex}"

  tags = {
    Name        = "DevOps-Kickstart-Bucket"
    Environment = "Dev"
  }
}

# Optional: Output the bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}
