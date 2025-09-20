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
  type        = string
  default     = "devops-kickstart-bucket-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 4
}


