variable "account_name" {
  description = "Account or environment name."
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN to send a notification when the synthetic alarm is triggered."
  type        = string
}

variable "app_endpoint_name" {
  description = "Name for this canary. Has a maximum length of 21 characters. Valid characters are lowercase alphanumeric, hyphen, or underscore."
  type        = string
}

variable "app_endpoint_url" {
  description = "Application or endpoint URL (e.g. https://www.dnx.solutions)"
  type        = string
}

variable "schedule_expression" {
  description = "Rate expression or cron expression that defines how often the canary is to run. For rate expression, the syntax is rate(number unit). unit can be minute, minutes, or hour. For cron expression, the syntax is cron(expression)."
  type        = string
  default     = "rate(30 minutes)"
}

variable "s3_bucket" {
  description = "Full bucket name which is used if your canary script is located in S3. The bucket must already exist."
  type        = string
}

variable "runtime_version" {
  description = "Runtime version to use for the canary. Versions change often so consult the Amazon CloudWatch documentation for the latest valid versions."
  type        = string
  default     = "syn-nodejs-puppeteer-3.9"
}

variable "alarm_period" {
  description = "(Optional) The period in seconds over which the specified statistic is applied."
  type        = number
  default     = 300
}

