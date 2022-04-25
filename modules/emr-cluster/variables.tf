#--------------------------------------------------------------
# EMR Cluster
#--------------------------------------------------------------

variable "additional_info" {
  type        = string
  default     = null
  description = "(Optional) A JSON string for selecting additional features such as adding proxy information. Note: Currently there is no API to retrieve the value of this argument after EMR cluster creation from provider, therefore Terraform cannot detect drift from the actual EMR cluster if its value is changed outside Terraform."
}

variable "applications" {
  type        = set(string)
  default     = null
  description = "(Optional) A list of applications for the cluster."
}

variable "autoscaling_role" {
  type        = string
  default     = null
  description = "(Optional) An IAM role for automatic scaling policies. The IAM role provides permissions that the automatic scaling feature requires to launch and terminate EC2 instances in an instance group"
}

variable "auto_termination_policy" {
  type        = list(any)
  default     = []
  description = "(Optional) An auto-termination policy for an Amazon EMR cluster. An auto-termination policy defines the amount of idle time in seconds after which a cluster automatically terminates."
}

variable "bootstrap_action" {
  type = list(object({
    name = string
    path = string
    args = list(string)
  }))
  default     = []
  description = "(Optional) Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
}

variable "cluster_name" {
  type        = string
  default     = null
  description = "(Required) The name of the job flow"
}

variable "configurations" {
  type        = string
  default     = null
  description = "(Optional) List of configurations supplied for the EMR cluster you are creating"
}

variable "configurations_json" {
  type        = string
  default     = null
  description = "(Optional) A JSON string for supplying list of configurations for the EMR cluster."
}

variable "core_instance_fleet" {
  type        = list(any)
  default     = []
  description = "(Optional) Configuration block to use an Instance Fleet for the core node type. Cannot be specified if any core_instance_group configuration blocks are set."
}

variable "core_instance_group" {
  type        = list(any)
  default     = []
  description = "(Optional) Configuration block to use an Instance Group for the core node type."
}

variable "custom_ami_id" {
  type        = string
  default     = null
  description = "(Optional) A custom Amazon Linux AMI for the cluster (instead of an EMR-owned AMI)."
}

variable "ebs_root_volume_size" {
  type        = number
  default     = null
  description = "(Optional) Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later."
}

variable "ec2_attributes" {
  type        = list(any)
  default     = []
  description = "(Optional) Attributes for the EC2 instances running the job flow."
}

variable "log_uri" {
  type        = string
  default     = null
  description = "(Optional) S3 bucket to write the log files of the job flow. If a value is not provided, logs are not created"
}

variable "keep_job_flow_alive_when_no_steps" {
  type        = bool
  default     = true
  description = "(Optional) Switch on/off run cluster with no steps or when all steps are complete (default is on)"
}

variable "kerberos_attributes" {
  type        = list(any)
  default     = []
  description = "(Optional) Kerberos configuration for the cluster."
}

variable "log_encryption_kms_key_id" {
  type        = string
  default     = null
  description = "(Optional) AWS KMS customer master key (CMK) key ID or arn used for encrypting log files. This attribute is only available with EMR version 5.30.0 and later, excluding EMR 6.0.0."
}

variable "master_instance_fleet" {
  type        = list(any)
  default     = []
  description = "(Optional) Configuration block to use an Instance Fleet for the master node type. Cannot be specified if any master_instance_group configuration blocks are set."
}

variable "master_instance_group" {
  type        = list(any)
  default     = []
  description = "(Optional) Configuration block to use an Instance Group for the master node type."
}

variable "release_label" {
  type        = string
  description = "(Required) The release label for the Amazon EMR release"
}

variable "scale_down_behavior" {
  type        = string
  default     = null
  description = "(Optional) The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized."
}

variable "security_configuration" {
  type        = string
  default     = null
  description = "(Optional) The security configuration name to attach to the EMR cluster. Only valid for EMR clusters with release_label 4.8.0 or greater"
}

variable "service_role" {
  type        = string
  default     = null
  description = "(Required) IAM role that will be assumed by the Amazon EMR service to access AWS resources"
}

variable "step" {
  type        = list(any)
  default     = []
  description = "(Optional) List of steps to run when creating the cluster."
}

variable "step_concurrency_level" {
  type        = number
  default     = 1
  description = "(Optional) The number of steps that can be executed concurrently. You can specify a maximum of 256 steps."
}

variable "termination_protection" {
  type        = bool
  default     = false
  description = "(Optional) Switch on/off termination protection (default is false, except when using multiple master nodes). Before attempting to destroy the resource when termination protection is enabled, this configuration must be applied with its value set to false."
}

variable "visible_to_all_users" {
  type        = bool
  default     = true
  description = "(Optional) Whether the job flow is visible to all IAM users of the AWS account associated with the job flow."
}
