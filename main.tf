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

resource "aws_security_group" "gh_runners_sg" {
  name   = "gh_runners_${var.repo}_sg"
  vpc_id = aws_vpc.vpc.id
  # tags = {
  #   Name = "gh_runners_sg"
  # }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.gh_runners_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.gh_runners_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "gh_runner" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sb_pub.id
  key_name                    = data.aws_key_pair.gh_runner_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.gh_runners_sg.id]
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
  root_block_device {
    volume_size = 30
  }
  tags = {
    Name = "gh_runner_${var.repo}_vm"
  }
  depends_on = [aws_internet_gateway.igw]
  lifecycle {
    create_before_destroy = true
  }
}