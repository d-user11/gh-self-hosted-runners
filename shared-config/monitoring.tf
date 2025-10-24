
resource "aws_cloudwatch_log_group" "github_runners_log_group" {
  name              = "/${local.project_name}/logs"
  retention_in_days = 1
}

data "template_file" "cloudwatch_agent_config" {
  template = file("${path.module}/cloudwatch_agent_config.json.tpl")

  vars = {
    log_group_name = aws_cloudwatch_log_group.github_runners_log_group.name
  }
}

resource "aws_ssm_parameter" "cloudwatch_agent_config" {
  name  = "/cloudwatch-agent/config"
  type  = "String"
  value = data.template_file.cloudwatch_agent_config.rendered
}
