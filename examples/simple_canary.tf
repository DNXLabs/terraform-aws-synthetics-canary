module "canary" {
  source              = "git::https://github.com/DNXLabs/terraform-aws-synthetics-canary.git"
  account_name        = "simple-test"
  s3_bucket           = "" # <example_bucket>
  schedule_expression = "rate(30 minutes)"
  app_endpoint_name   = "dnxsolutions"
  app_endpoint_url    = "https://dnx.solutions"
  sns_topic_arn       = "" # example_sns_topic_arn
}