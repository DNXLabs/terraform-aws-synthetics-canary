resource "aws_iam_role" "synthetics_monitor" {
  name               = "CloudWatchSyntheticsRole-${random_string.random.result}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.synthetics_monitor_assume.json
}

resource "aws_iam_role_policy_attachment" "synthetics_monitor" {
  role       = aws_iam_role.synthetics_monitor.name
  policy_arn = aws_iam_policy.synthetics_monitor.arn
}

data "aws_iam_policy_document" "synthetics_monitor_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "synthetics_monitor" {
  name        = "CloudWatchSyntheticsPolicy-${random_string.random.result}"
  description = "Cloudwatch Synthetics Policy."
  policy      = data.aws_iam_policy_document.synthetics_monitor.json
}

data "aws_iam_policy_document" "synthetics_monitor" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.s3_bucket}/canary/${data.aws_region.current.name}/${var.account_name}-${var.app_endpoint_name}/*"] #todo
    actions = ["s3:PutObject",
    "s3:GetObject"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.s3_bucket}"]
    actions   = ["s3:GetBucketLocation"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/cwsyn-${var.account_name}-${var.app_endpoint_name}*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup"
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:ListAllMyBuckets",
      "xray:PutTraceSegments"
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["cloudwatch:PutMetricData"]

    condition {
      test     = "StringEquals"
      variable = "cloudwatch:namespace"
      values   = ["CloudWatchSynthetics"]
    }
  }
}

resource "random_string" "random" {
  length      = 12
  min_numeric = 12
}