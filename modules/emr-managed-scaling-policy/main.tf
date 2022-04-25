#--------------------------------------------------------------
# EMR Managed Scaling Policy
#--------------------------------------------------------------

resource "aws_emr_managed_scaling_policy" "this" {
  count      = module.this.enabled ? 1 : 0
  cluster_id = var.cluster_id
  dynamic "compute_limits" {
    for_each = var.compute_limits
    content {
      unit_type                       = lookup(compute_limits.value, "unit_type", null)
      minimum_capacity_units          = lookup(compute_limits.value, "minimum_capacity_units", null)
      maximum_capacity_units          = lookup(compute_limits.value, "maximum_capacity_units", null)
      maximum_ondemand_capacity_units = lookup(compute_limits.value, "maximum_ondemand_capacity_units", null)
      maximum_core_capacity_units     = lookup(compute_limits.value, "maximum_core_capacity_units", null)
    }
  }
}
