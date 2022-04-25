#--------------------------------------------------------------
# VPC Security Group
#--------------------------------------------------------------

variable "master_allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks to be allowed to access the master instances"
}

variable "master_allowed_security_groups" {
  type        = list(string)
  default     = []
  description = "List of security groups to be allowed to connect to the master instances"
}

variable "slave_allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks to be allowed to access the slave instances"
}

variable "slave_allowed_security_groups" {
  type        = list(string)
  default     = []
  description = "List of security groups to be allowed to connect to the slave instances"
}

variable "subnet_type" {
  type        = string
  default     = "private"
  description = "The type of subnet the EMR cluster is provisioned in. Used to determine if service related security groups are required. Defaults to 'private'"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to create the security groups in"
}

#--------------------------------------------------------------
# Bootstrap S3 Object
#--------------------------------------------------------------

variable "bootstrap_s3_bucket" {
  type        = string
  default     = null
  description = "(Required) The name of the bucket to put the file in. Alternatively, an S3 access point ARN can be specified."
}

variable "bootstrap_s3_key" {
  type        = string
  default     = null
  description = "(Required) The name of the object once it is in the bucket."
}

variable "bootstrap_s3_server_side_encryption" {
  type        = string
  default     = "AES256"
  description = "(Optional) Specifies server-side encryption of the object in S3. Valid values are 'AES256' and 'aws:kms'."
}

variable "bootstrap_s3_kms_key_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the AWS KMS Key ARN to use for object encryption. This value is a fully qualified ARN of the KMS Key."
}

#--------------------------------------------------------------
# EMR Autoscaling
#--------------------------------------------------------------

variable "core_instance_autoscaling_min_capacity" {
  type        = number
  default     = 1
  description = "(Required) The min capacity of the scalable target."
}

variable "core_instance_autoscaling_max_capacity" {
  type        = number
  default     = 1
  description = "(Required) The max capacity of the scalable target."
}

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
  description = "The name of the job flow"
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

# core instance group
variable "core_instance_group_instance_type" {
  type        = string
  default     = null
  description = "(Required) EC2 instance type for all instances in the instance group."
}

variable "core_instance_group_autoscaling_policy" {
  type        = string
  default     = null
  description = "(Optional) String containing the EMR Auto Scaling Policy JSON."
}

variable "core_instance_group_instance_count" {
  type        = number
  default     = 1
  description = "(Optional) Target number of instances for the instance group. Must be at least 1. Defaults to 1."
}

variable "core_instance_group_ebs_config_size" {
  type        = number
  default     = null
  description = "(Required) The volume size, in gibibytes (GiB)."
}

variable "core_instance_group_ebs_config_type" {
  type        = string
  default     = null
  description = "(Required) The volume type. Valid options are gp2, io1, standard and st1."
}

variable "core_instance_group_ebs_config_iops" {
  type        = number
  default     = null
  description = "(Optional) The number of I/O operations per second (IOPS) that the volume supports"
}

variable "core_instance_group_ebs_config_volumes_per_instance" {
  type        = number
  default     = 1
  description = "(Optional) The number of EBS volumes with this configuration to attach to each EC2 instance in the instance group (default is 1)"
}

variable "core_instance_group_bid_price" {
  type        = string
  default     = null
  description = "(Optional) Bid price for each EC2 instance in the instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances."
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

# ec2 attributes
variable "ec2_attributes_key_name" {
  type        = string
  default     = null
  description = "(Optional) Amazon EC2 key pair that can be used to ssh to the master node as the user called hadoop"
}

variable "ec2_attributes_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) VPC subnet id where you want the job flow to launch. Cannot specify the cc1.4xlarge instance type for nodes of a job flow launched in a Amazon VPC"
}

variable "ec2_attributes_additional_master_security_groups" {
  type        = string
  default     = null
  description = "(Optional) String containing a comma separated list of additional Amazon EC2 security group IDs for the master node"
}

variable "ec2_attributes_additional_slave_security_groups" {
  type        = string
  default     = null
  description = "(Optional) String containing a comma separated list of additional Amazon EC2 security group IDs for the slave nodes as a comma separated string"
}

variable "ec2_attributes_emr_managed_master_security_group" {
  type        = string
  default     = null
  description = "(Optional) Identifier of the Amazon EC2 EMR-Managed security group for the master node"
}

variable "ec2_attributes_emr_managed_slave_security_group" {
  type        = string
  default     = null
  description = "(Optional) Identifier of the Amazon EC2 EMR-Managed security group for the slave nodes"
}

variable "ec2_attributes_service_access_security_group" {
  type        = string
  default     = null
  description = "(Optional) Identifier of the Amazon EC2 service-access security group - required when the cluster runs on a private subnet"
}

variable "ec2_attributes_instance_profile" {
  type        = string
  default     = null
  description = "(Required) Instance Profile for EC2 instances of the cluster assume this role"
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

# kerberos attributes
variable "kerberos_attributes_ad_domain_join_password" {
  type        = string
  default     = null
  description = "(Optional) The Active Directory password for ad_domain_join_user. Terraform cannot perform drift detection of this configuration"
}

variable "kerberos_attributes_ad_domain_join_user" {
  type        = string
  default     = null
  description = "(Optional) Required only when establishing a cross-realm trust with an Active Directory domain. A user with sufficient privileges to join resources to the domain. Terraform cannot perform drift detection of this configuration."
}

variable "kerberos_attributes_cross_realm_trust_principal_password" {
  type        = string
  default     = null
  description = "(Optional) Required only when establishing a cross-realm trust with a KDC in a different realm. The cross-realm principal password, which must be identical across realms. Terraform cannot perform drift detection of this configuration."
}

variable "kerberos_attributes_kdc_admin_password" {
  type        = string
  default     = null
  description = "(Required) The password used within the cluster for the kadmin service on the cluster-dedicated KDC, which maintains Kerberos principals, password policies, and keytabs for the cluster. Terraform cannot perform drift detection of this configuration."
}

variable "kerberos_attributes_realm" {
  type        = string
  default     = null
  description = "(Required) The name of the Kerberos realm to which all nodes in a cluster belong. For example, EC2.INTERNAL"
}

# master instance group
variable "master_instance_group_instance_type" {
  type        = string
  default     = null
  description = "(Required) EC2 instance type for all instances in the instance group."
}

variable "master_instance_group_bid_price" {
  type        = string
  default     = null
  description = "(Optional) Bid price for each EC2 instance in the instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances"
}

variable "master_instance_group_ebs_config_size" {
  type        = number
  default     = null
  description = "(Required) The volume size, in gibibytes (GiB)."
}

variable "master_instance_group_ebs_config_type" {
  type        = string
  default     = null
  description = "(Required) The volume type. Valid options are gp2, io1, standard and st1."
}

variable "master_instance_group_ebs_config_iops" {
  type        = number
  default     = null
  description = "(Optional) The number of I/O operations per second (IOPS) that the volume supports"
}

variable "master_instance_group_ebs_config_volumes_per_instance" {
  type        = number
  default     = 1
  description = "(Optional) The number of EBS volumes with this configuration to attach to each EC2 instance in the instance group (default is 1)"
}

variable "master_instance_group_instance_count" {
  type        = number
  default     = null
  description = "(Optional) Target number of instances for the instance group. Must be 1 or 3. Defaults to 1. Launching with multiple master nodes is only supported in EMR version 5.23.0+, and requires this resource's core_instance_group to be configured. Public (Internet accessible) instances must be created in VPC subnets that have map public IP on launch enabled. Termination protection is automatically enabled when launched with multiple master nodes and Terraform must have the termination_protection = false configuration applied before destroying this resource."
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

#--------------------------------------------------------------
# Cloudwatch Event Target
#--------------------------------------------------------------

variable "sns_topic_arn" {
  type        = string
  default     = null
  description = "(Required) The Amazon Resource Name (ARN) associated of the SNS target."
}
