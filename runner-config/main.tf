resource "aws_instance" "github_runner" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name = data.aws_key_pair.gh_runner_key_pair.key_name

  subnet_id                   = data.aws_subnet.subnet.id
  vpc_security_group_ids      = [data.aws_security_group.security_group.id]
  associate_public_ip_address = true

  user_data = templatefile(
    "${path.module}/user_data.sh",
    {
      owner        = var.owner,
      repo         = var.repo,
      access_token = var.access_token,
    }
  )
  user_data_replace_on_change = true

  iam_instance_profile = data.aws_iam_instance_profile.cloudwatch_agent_profile.name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "repo_${var.repo}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
