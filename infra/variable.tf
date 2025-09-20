variable "ec2_ssh_key" {
  description = "Private SSH key for EC2"
  type        = string
}

variable "ghcr_pat" {
  description = "GitHub Container Registry PAT"
  type        = string
}
variable "bucket_prefix" {
  type    = string
  default = "devops-kickstart-bucket"
  description = "Prefix for the S3 bucket name"
}



