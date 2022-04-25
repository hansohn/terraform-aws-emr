#--------------------------------------------------------------
# EMR Managed Scaling Policy
#--------------------------------------------------------------

variable "cluster_id" {
  type        = string
  description = "(Required) The id of the EMR cluster"
}

variable "compute_limits" {
  type        = list(any)
  description = "(Required) Configuration block with compute limit settings."
}
