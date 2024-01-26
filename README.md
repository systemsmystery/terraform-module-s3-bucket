# Terraform Module - S3 Bucket

Module to create a S3 bucket, optionally setup backup and bucket encryption.

## Terraform Resources

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.plan](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/backup_plan) | resource |
| [aws_backup_selection.selection](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/backup_selection) | resource |
| [aws_backup_vault.vault](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/backup_vault) | resource |
| [aws_iam_role.backup](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.backup](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.restore](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.mastodon](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.logging](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.bucket](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.bucket](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.bucket](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.bucket](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy_document.backup](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_kms_key_arn"></a> [backup\_kms\_key\_arn](#input\_backup\_kms\_key\_arn) | The ARN of the KMS key to use for this buckets backup | `string` | `""` | no |
| <a name="input_backup_retention"></a> [backup\_retention](#input\_backup\_retention) | The number of days to retain backups for | `number` | `7` | no |
| <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule) | The schedule for this buckets backup | `string` | `"cron(0 0 * * ? *)"` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket to create | `string` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | The policy to apply to this bucket | `string` | `""` | no |
| <a name="input_data_kms_key_arn"></a> [data\_kms\_key\_arn](#input\_data\_kms\_key\_arn) | The ARN of the KMS key to use for this bucket | `string` | `""` | no |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | Whether Amazon S3 should enable backup on this bucket | `bool` | `true` | no |
| <a name="input_enable_bucket_logging"></a> [enable\_bucket\_logging](#input\_enable\_bucket\_logging) | Whether Amazon S3 should enable logging on this bucket | `bool` | `true` | no |
| <a name="input_enable_lifecycle_IA"></a> [enable\_lifecycle\_IA](#input\_enable\_lifecycle\_IA) | Enable the lifecycle policy to transition to IA | `string` | `"Enabled"` | no |
| <a name="input_enable_lifecycle_delete_expired"></a> [enable\_lifecycle\_delete\_expired](#input\_enable\_lifecycle\_delete\_expired) | Enable the lifecycle policy to delete expired versions | `string` | `"Enabled"` | no |
| <a name="input_enable_lifecycle_delete_noncurrent"></a> [enable\_lifecycle\_delete\_noncurrent](#input\_enable\_lifecycle\_delete\_noncurrent) | Enable the lifecycle policy to delete noncurrent versions | `string` | `"Enabled"` | no |
| <a name="input_enable_lifecycle_policy"></a> [enable\_lifecycle\_policy](#input\_enable\_lifecycle\_policy) | The lifecycle policy should be applied to this bucket. Sets transition to IA and remove noncurrent versions. | `bool` | `true` | no |
| <a name="input_enable_ownership_controls"></a> [enable\_ownership\_controls](#input\_enable\_ownership\_controls) | Whether Amazon S3 should enable ownership controls on this bucket | `bool` | `true` | no |
| <a name="input_enable_sse"></a> [enable\_sse](#input\_enable\_sse) | Whether Amazon S3 should enable server-side encryption on this bucket | `bool` | `true` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Whether Amazon S3 should enable versioning on this bucket | `bool` | `true` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket | `bool` | `true` | no |
| <a name="input_lifecycle_move_to_IA_days"></a> [lifecycle\_move\_to\_IA\_days](#input\_lifecycle\_move\_to\_IA\_days) | The number of days to transition to IA | `number` | `0` | no |
| <a name="input_lifecycle_remove_expired_days"></a> [lifecycle\_remove\_expired\_days](#input\_lifecycle\_remove\_expired\_days) | The number of days to remove expired versions | `number` | `30` | no |
| <a name="input_lifecycle_remove_noncurrent_days"></a> [lifecycle\_remove\_noncurrent\_days](#input\_lifecycle\_remove\_noncurrent\_days) | The number of days to remove noncurrent versions | `number` | `30` | no |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | The name of the bucket to log to | `string` | `""` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket | `bool` | `true` | no |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm) | The server-side encryption algorithm to use for this bucket | `string` | `"AES256"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the bucket |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the bucket |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
