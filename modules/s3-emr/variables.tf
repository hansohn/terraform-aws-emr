#--------------------------------------------------------------
# Common
#--------------------------------------------------------------

variable "mini_attrs" {
  type        = bool
  default     = false
  description = "(Optional) Enable/Disable use of minified aws attributes (accounts, regions, etc)"
}

variable "s3_replica_region" {
  type        = string
  default     = null
  description = "(optional) AWS Region to replicate s3 buckets to"
}

#--------------------------------------------------------------
# S3 Bucket Admin
#--------------------------------------------------------------

variable "s3_emr_admin_allow_encrypted_uploads_only" {
  type        = bool
  default     = false
  description = "Set to true to prevent uploads of unencrypted objects to S3 bucket"
}

variable "s3_emr_admin_force_destroy" {
  type        = bool
  default     = false
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
}

variable "s3_emr_admin_sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "(required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
}

#--------------------------------------------------------------
# S3 Bucket EMR Checkpoint
#--------------------------------------------------------------

variable "s3_emr_checkpoints_allow_encrypted_uploads_only" {
  type        = bool
  default     = false
  description = "Set to true to prevent uploads of unencrypted objects to S3 bucket"
}

variable "s3_emr_checkpoints_force_destroy" {
  type        = bool
  default     = false
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
}

variable "s3_emr_checkpoints_sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "(required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
}

#--------------------------------------------------------------
# S3 Bucket EMR Data
#--------------------------------------------------------------

variable "s3_emr_data_allow_encrypted_uploads_only" {
  type        = bool
  default     = false
  description = "Set to true to prevent uploads of unencrypted objects to S3 bucket"
}

variable "s3_emr_data_force_destroy" {
  type        = bool
  default     = false
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
}

variable "s3_emr_data_sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "(required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
}

#--------------------------------------------------------------
# S3 Bucket EMR Logs
#--------------------------------------------------------------

variable "s3_emr_logs_force_destroy" {
  type        = bool
  default     = false
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
}

variable "s3_emr_logs_sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "(required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
}

