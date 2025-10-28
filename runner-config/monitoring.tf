# TODO: Create an alarm that will reboot the server if the system status check fails 

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.repo}_runner"

  dashboard_body = templatefile(
    "dashboard.json.tpl",
    {
      region      = aws_instance.github_runner.region
      instance_id = aws_instance.github_runner.id
      private_ip  = replace(aws_instance.github_runner.private_ip, ".", "-")
    }
  )
}
