data "archive_file" "synthetics_monitor" {
  type        = "zip"
  output_path = "tmp/canary-${var.account_name}-${var.app_endpoint_name}.zip"

  source {
    content = templatefile("${path.module}/src/heartbeat_blueprint.tmpl", {
      urls = "${var.app_endpoint_url}"
    })
    filename = "nodejs/node_modules/pageLoadBlueprint.js"
  }

}

resource "aws_synthetics_canary" "synthetics_monitor" {
  name                 = "${var.account_name}-${var.app_endpoint_name}"
  artifact_s3_location = "s3://${var.s3_bucket}/canary/${data.aws_region.current.name}/${var.account_name}-${var.app_endpoint_name}/"
  execution_role_arn   = aws_iam_role.synthetics_monitor.arn
  handler              = "pageLoadBlueprint.handler"
  runtime_version      = var.runtime_version
  zip_file             = data.archive_file.synthetics_monitor.output_path
  start_canary         = true

  schedule {
    expression = var.schedule_expression
  }

}