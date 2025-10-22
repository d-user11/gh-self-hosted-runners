variable "owner" {
  description = "The account owner of the repository. The name is not case sensitive"
  type        = string
  default     = "d-user11"
}

variable "repo" {
  description = "The name of the repository without the .git extension. The name is not case sensitive."
  type        = string
  default     = "gh-self-hosted-runners"
}

variable "access_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}
