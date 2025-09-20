output "bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}

output "ec2_public_ip" {
  value = aws_instance.devops_ec2.public_ip
}
