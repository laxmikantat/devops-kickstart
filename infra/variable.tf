variable "GHCR_PAT" {
  description = "GitHub Container Registry Personal Access Token"
  type        = string
}
variable "ghcr_pat" {
  description = "GitHub Container Registry PAT"
  type        = string
  sensitive   = true
}
