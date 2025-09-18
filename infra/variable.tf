variable "GHCR_PAT" {
  description = "GitHub Container Registry PAT"
  type        = string
  sensitive   = true
}

variable "ec2_ssh_key" {
  description = "Private SSH key for EC2 (from GitHub Secrets)"
  type        = string
  sensitive   = true
}