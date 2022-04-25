#--------------------------------------------------------------
# EMR Cluster
#--------------------------------------------------------------

resource "aws_emr_instance_group" "this" {
  count               = module.this.enabled ? 1 : 0
  autoscaling_policy  = var.autoscaling_policy
  bid_price           = var.bid_price
  cluster_id          = var.cluster_id
  configurations_json = var.configurations_json
  dynamic "ebs_config" {
    for_each = var.ebs_config
    content {
      iops                 = lookup(ebs_config.value, "iops", null)
      size                 = lookup(ebs_config.value, "size", null)
      type                 = lookup(ebs_config.value, "type", null)
      volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
    }
  }
  ebs_optimized  = var.ebs_optimized
  instance_count = var.instance_count
  instance_type  = var.instance_type
  name           = coalesce(var.instance_group_name, module.this.id)
}
