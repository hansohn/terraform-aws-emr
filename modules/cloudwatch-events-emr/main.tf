#--------------------------------------------------------------
# Cloudwatch Event Rule
#-------------------------------------------------------------

locals {
  event_pattern = templatefile(
    "${path.module}/templates/emr_event_pattern.json.tpl",
    { emr_cluster_id = var.emr_cluster_id }
  )
}

module "cloudwatch_event_rule_emr" {
  source        = "git::https://gitlab.hrt.io/Infrastructure/terraform/terraform-aws-cloudwatch.git//modules/cloudwatch-event-rule?ref=1.0.0"
  context       = module.this.context
  enabled       = module.this.enabled
  name          = coalesce(module.this.name, "emr")
  event_pattern = local.event_pattern
  description   = "EMR Cloudwatch Events for Cluster '${var.emr_cluster_id}'"
  role_arn      = var.role_arn
}

#--------------------------------------------------------------
# Cloudwatch Event Target
#-------------------------------------------------------------

module "cloudwatch_event_target_emr_sns" {
  source     = "git::https://gitlab.hrt.io/Infrastructure/terraform/terraform-aws-cloudwatch.git//modules/cloudwatch-event-target?ref=1.0.0"
  context    = module.this.context
  attributes = compact(concat(var.attributes, ["sns"]))
  enabled    = module.this.enabled
  name       = coalesce(module.this.name, "emr")
  rule       = module.cloudwatch_event_rule_emr.name
  arn        = var.sns_topic_arn
}
