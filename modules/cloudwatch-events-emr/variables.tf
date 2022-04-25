#--------------------------------------------------------------
# Cloudwatch Event Rule
#--------------------------------------------------------------

variable "emr_cluster_id" {
  type        = string
  description = "Id the target EMR cluster to use as event source"
}

variable "role_arn" {
  type        = string
  default     = null
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
}

#--------------------------------------------------------------
# Cloudwatch Event Target
#--------------------------------------------------------------

variable "sns_topic_arn" {
  type        = string
  description = "(Required) The Amazon Resource Name (ARN) associated of the SNS target."
}
