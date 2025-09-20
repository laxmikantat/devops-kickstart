variable "ec2_ssh_key" {
  description = "Private SSH key for EC2"
  type        = string
}

variable "ghcr_pat" {
  description = "GitHub Container Registry PAT"
  type        = string
}
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  default = "dev-ops-kick-laxmikat:"
  type        = string
}



