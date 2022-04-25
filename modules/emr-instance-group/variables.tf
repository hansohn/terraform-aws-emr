#--------------------------------------------------------------
# EMR Instance Group
#--------------------------------------------------------------

variable "autoscaling_policy" {
  type        = string
  default     = null
  description = "(Optional) The autoscaling policy document. This is a JSON formatted string"
}

variable "configurations_json" {
  type        = string
  default     = null
  description = "(Optional) A JSON string for supplying list of configurations specific to the EMR instance group."
}

variable "bid_price" {
  type        = string
  default     = null
  description = "(Optional) If set, the bid price for each EC2 instance in the instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances."
}

variable "cluster_id" {
  type        = string
  description = "(Required) ID of the EMR Cluster to attach to. Changing this forces a new resource to be created."
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "(optional) target number of instances for the instance group."
}

variable "instance_type" {
  type        = string
  description = "(Required) The EC2 instance type for all instances in the instance group. Changing this forces a new resource to be created."
}

variable "ebs_config" {
  type        = list(any)
  default     = null
  description = "(Optional) One or more ebs_config blocks as defined below. Changing this forces a new resource to be created."
}

variable "ebs_optimized" {
  type        = bool
  default     = null
  description = "(Optional) Indicates whether an Amazon EBS volume is EBS-optimized. Changing this forces a new resource to be created."
}

variable "instance_group_name" {
  type        = string
  default     = null
  description = "(Required) Human friendly name given to the instance group. Changing this forces a new resource to be created."
}
