#--------------------------------------------------------------
# EMR
#--------------------------------------------------------------

variable "emr_iam_policy_name_app" {
  type        = string
  default     = "EMR"
  description = "App name to include when auto generating policy_name_prefix. Defaults to 'EMR'"
}

variable "emr_iam_policy_name_prefix" {
  type        = string
  default     = ""
  description = "Prefix to use when naming EMR IAM read/full access policies"
}

variable "emr_iam_policy_resources" {
  type        = list(string)
  default     = []
  description = "List of resources to include in EMR IAM read/full access policies"
}

variable "emr_iam_policy_s3_resources" {
  type        = list(string)
  default     = ["*"]
  description = "List of S3 resources to include in EMR IAM read/full access policies"
}

variable "emr_iam_full_access_role_name" {
  type        = string
  default     = ""
  description = "IAM role name to attach EMR IAM full access policy to"
}

variable "emr_iam_full_access_group_name" {
  type        = string
  default     = ""
  description = "IAM group name to attach EMR IAM full access policy to"
}
