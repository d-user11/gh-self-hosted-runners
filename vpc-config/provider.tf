provider "aws" {
  region = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::559089787357:role/Terraform"
  }
}
