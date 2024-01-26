resource "aws_backup_vault" "vault" {
  # checkov:skip=CKV_AWS_166
  count       = var.enable_backup ? 1 : 0
  name        = "s3_bucket_${replace(aws_s3_bucket.bucket.id, "/[-.]/", "_")}_vault"
  kms_key_arn = var.backup_kms_key_arn
}

resource "aws_backup_plan" "plan" {
  count = var.enable_backup ? 1 : 0
  name  = "s3_bucket_${replace(aws_s3_bucket.bucket.id, "/[-.]/", "_")}_backup_plan"

  rule {
    rule_name         = "s3_bucket_${replace(aws_s3_bucket.bucket.id, "/[-.]/", "_")}_backup_rule"
    target_vault_name = aws_backup_vault.vault[0].id
    schedule          = var.backup_schedule

    lifecycle {
      delete_after = var.backup_retention
    }
  }
}

resource "aws_backup_selection" "selection" {
  count        = var.enable_backup ? 1 : 0
  iam_role_arn = aws_iam_role.backup[0].arn
  name         = "s3_bucket_${aws_s3_bucket.bucket.id}-selection"
  plan_id      = aws_backup_plan.plan[0].id

  resources = [aws_s3_bucket.bucket.arn]
}

data "aws_iam_policy_document" "backup" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "backup" {
  count = var.enable_backup ? 1 : 0

  name               = "s3_bucket_${replace(aws_s3_bucket.bucket.id, "/[-.]/", "_")}_backup_role"
  assume_role_policy = data.aws_iam_policy_document.backup.json
}

resource "aws_iam_role_policy_attachment" "backup" {
  count = var.enable_backup ? 1 : 0

  role       = aws_iam_role.backup[0].name
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
}

resource "aws_iam_role_policy_attachment" "restore" {
  count = var.enable_backup ? 1 : 0

  role       = aws_iam_role.backup[0].name
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Restore"
}
