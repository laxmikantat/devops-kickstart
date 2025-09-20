output "bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.devops_ec2.public_ip
}
