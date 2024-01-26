#tfsec:ignore:aws-s3-enable-versioning
# kics-scan disable=c5b31ab9-0f26-4a49-b8aa-4cc064392f4d,6726dcc0-5ff5-459d-b473-a780bef7665c
resource "aws_s3_bucket" "bucket" {
  # checkov:skip=CKV_AWS_144
  # checkov:skip=CKV2_AWS_62
  # checkov:skip=CKV_AWS_145
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  depends_on              = [aws_s3_bucket.bucket]
}

resource "aws_s3_bucket_ownership_controls" "bucket" {
  # checkov:skip=CKV2_AWS_65
  count  = var.enable_ownership_controls ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  count  = var.enable_sse ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.data_kms_key_arn
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "mastodon" {
  # checkov:skip=CKV_AWS_300:Already covered
  count  = var.enable_lifecycle_policy ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  rule {
    id     = "move-to-Intelligent-Tiering"
    status = var.enable_lifecycle_IA
    transition {
      storage_class = "INTELLIGENT_TIERING"
      days          = var.lifecycle_move_to_IA_days
    }
  }
  rule {
    id     = "remove-noncurrent"
    status = var.enable_lifecycle_delete_noncurrent
    noncurrent_version_expiration {
      noncurrent_days = var.lifecycle_remove_noncurrent_days
    }
  }
  rule {
    id     = "remove-expired"
    status = var.enable_lifecycle_delete_expired
    expiration {
      days = var.lifecycle_remove_expired_days
    }
  }
}

resource "aws_s3_bucket_logging" "logging" {
  count         = var.enable_bucket_logging ? 1 : 0
  bucket        = aws_s3_bucket.bucket.id
  target_bucket = var.logging_bucket
  target_prefix = "${aws_s3_bucket.bucket.id}/"
}

resource "aws_s3_bucket_policy" "policy" {
  count  = var.bucket_policy != "" ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  policy = var.bucket_policy
}
