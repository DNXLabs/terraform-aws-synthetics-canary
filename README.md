# terraform-aws-template

[![Lint Status](https://github.com/DNXLabs/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-template)](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_name | Account or environment name. | `string` | n/a | yes |
| alarm\_period | (Optional) The period in seconds over which the specified statistic is applied. | `number` | `300` | no |
| app\_endpoint\_name | Name for this canary. Has a maximum length of 21 characters. Valid characters are lowercase alphanumeric, hyphen, or underscore. | `string` | n/a | yes |
| app\_endpoint\_url | Application or endpoint URL (e.g. https://www.dnx.solutions) | `string` | n/a | yes |
| runtime\_version | Runtime version to use for the canary. Versions change often so consult the Amazon CloudWatch documentation for the latest valid versions. | `string` | `"syn-nodejs-puppeteer-3.9"` | no |
| s3\_bucket | Full bucket name which is used if your canary script is located in S3. The bucket must already exist. | `string` | n/a | yes |
| schedule\_expression | Rate expression or cron expression that defines how often the canary is to run. For rate expression, the syntax is rate(number unit). unit can be minute, minutes, or hour. For cron expression, the syntax is cron(expression). | `string` | `"rate(30 minutes)"` | no |
| sns\_topic\_arn | SNS topic ARN to send a notification when the synthetic alarm is triggered. | `string` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.