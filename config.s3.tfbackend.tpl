bucket      = "{S3_BUCKET}"
key         = "github_runners/${USER}/${REPO}/terraform.tfstate"
region      = "eu-west-1"
assume_role = {
    role_arn = "${ROLE_ARN}"
}