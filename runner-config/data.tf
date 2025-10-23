data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "gh_runner_key_pair" {
  key_name = "github-runner"
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = ["github_runners_public_subnet"]
  }
}

data "aws_security_group" "security_group" {
  name = "github_runners_sg"
}
