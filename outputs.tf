output "gh_runner_pub_ip" {
  value = aws_instance.gh_runner.public_ip
}

output "repo" {
  value = var.repo
}
