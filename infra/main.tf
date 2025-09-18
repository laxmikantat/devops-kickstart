provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "devops-kickstart-app-bucket-12345"

  tags = {
    Name        = "devops-kickstart-app-bucket"
    Environment = "dev"
  }
}
