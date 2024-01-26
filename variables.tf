variable "bucket_name" {
  type        = string
  description = "The name of the bucket to create"
}

variable "block_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  default     = true
}

variable "enable_ownership_controls" {
  type        = bool
  description = "Whether Amazon S3 should enable ownership controls on this bucket"
  default     = true
}

variable "enable_sse" {
  type        = bool
  description = "Whether Amazon S3 should enable server-side encryption on this bucket"
  default     = true
}

variable "sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use for this bucket"
  default     = "AES256"
}

variable "data_kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key to use for this bucket"
  default     = ""
}

variable "enable_versioning" {
  type        = bool
  description = "Whether Amazon S3 should enable versioning on this bucket"
  default     = true
}

variable "enable_backup" {
  type        = bool
  description = "Whether Amazon S3 should enable backup on this bucket"
  default     = true
}

variable "backup_kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key to use for this buckets backup"
  default     = ""
}

variable "backup_schedule" {
  type        = string
  description = "The schedule for this buckets backup"
  default     = "cron(0 0 * * ? *)"
}

variable "backup_retention" {
  type        = number
  description = "The number of days to retain backups for"
  default     = 7
}

variable "enable_bucket_logging" {
  type        = bool
  description = "Whether Amazon S3 should enable logging on this bucket"
  default     = true
}

variable "logging_bucket" {
  type        = string
  description = "The name of the bucket to log to"
  default     = ""
}

variable "bucket_policy" {
  type        = string
  description = "The policy to apply to this bucket"
  default     = ""
}

variable "enable_lifecycle_policy" {
  type        = bool
  description = "The lifecycle policy should be applied to this bucket. Sets transition to IA and remove noncurrent versions."
  default     = true
}

variable "lifecycle_move_to_IA_days" {
  type        = number
  description = "The number of days to transition to IA"
  default     = 0
}

variable "lifecycle_remove_noncurrent_days" {
  type        = number
  description = "The number of days to remove noncurrent versions"
  default     = 30
}

variable "enable_lifecycle_IA" {
  type        = string
  description = "Enable the lifecycle policy to transition to IA"
  default     = "Enabled"
  validation {
    condition     = can(regex("^(Enabled|Disabled)$", var.enable_lifecycle_IA))
    error_message = "enable_lifecycle_IA must be either Enabled or Disabled"
  }
}

variable "enable_lifecycle_delete_noncurrent" {
  type        = string
  description = "Enable the lifecycle policy to delete noncurrent versions"
  default     = "Enabled"
  validation {
    condition     = can(regex("^(Enabled|Disabled)$", var.enable_lifecycle_delete_noncurrent))
    error_message = "enable_lifecycle_delete_noncurrent must be either Enabled or Disabled"
  }
}

variable "enable_lifecycle_delete_expired" {
  type        = string
  description = "Enable the lifecycle policy to delete expired versions"
  default     = "Enabled"
  validation {
    condition     = can(regex("^(Enabled|Disabled)$", var.enable_lifecycle_delete_expired))
    error_message = "enable_lifecycle_delete_expired must be either Enabled or Disabled"
  }
}

variable "lifecycle_remove_expired_days" {
  type        = number
  description = "The number of days to remove expired versions"
  default     = 30
}
