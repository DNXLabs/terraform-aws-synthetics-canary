resource "aws_cloudwatch_metric_alarm" "synthetics_monitor" {
  alarm_name                = "Synthetics-Canary-Alarm-${var.account_name}-${var.app_endpoint_name}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "Failed"
  namespace                 = "CloudWatchSynthetics"
  period                    = var.alarm_period
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Synthetics alarm metric: Failed to load ${var.app_endpoint_url}"
  alarm_actions             = [var.sns_topic_arn]
  ok_actions                = [var.sns_topic_arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []
  dimensions = {
    CanaryName = "${aws_synthetics_canary.synthetics_monitor.id}"
  }
}