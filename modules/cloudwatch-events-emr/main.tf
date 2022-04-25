#--------------------------------------------------------------
# Labeling
#--------------------------------------------------------------

module "event_rule" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.this.context
  enabled = module.this.enabled
  name    = coalesce(module.this.name, "emr")
}

module "event_target" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  context    = module.this.context
  enabled    = module.this.enabled
  name       = coalesce(module.this.name, "emr")
  attributes = compact(concat(module.this.attributes, ["sns"]))
}

#--------------------------------------------------------------
# Cloudwatch Event Rule
#-------------------------------------------------------------

locals {
  event_pattern = templatefile(
    "${path.module}/templates/emr_event_pattern.json.tpl",
    { emr_cluster_id = var.emr_cluster_id }
  )
}

resource "aws_cloudwatch_event_rule" "this" {
  count = module.event_rule.enabled ? 1 : 0
  # description         = var.event_rule_description
  description = "EMR Cloudwatch Events for Cluster '${var.emr_cluster_id}'"
  # event_pattern       = var.event_rule_event_pattern
  event_pattern       = local.event_pattern
  is_enabled          = var.event_rule_is_enabled
  name                = var.event_rule_name != null ? var.event_rule_name : module.event_rule.id
  name_prefix         = var.event_rule_name_prefix
  role_arn            = var.event_rule_role_arn
  schedule_expression = var.event_rule_schedule_expression
  tags                = module.this.tags
}

#--------------------------------------------------------------
# Cloudwatch Event Target
#-------------------------------------------------------------

resource "aws_cloudwatch_event_target" "this" {
  count = module.event_target.enabled ? 1 : 0
  # rule = var.event_target_rule
  rule      = aws_cloudwatch_event_rule.this[0].name
  target_id = var.event_target_target_id != null ? var.event_target_target_id : module.event_target.id
  #arn = var.arn
  arn        = var.event_target_arn
  input      = var.event_target_input
  input_path = var.event_target_input_path
  role_arn   = var.event_target_role_arn
  dynamic "run_command_targets" {
    for_each = var.event_target_run_command_targets
    content {
      key    = lookup(run_command_targets.value, "key", null)
      values = lookup(run_command_targets.value, "values", null)
    }
  }
  dynamic "ecs_target" {
    for_each = var.event_target_ecs_target
    content {
      group       = lookup(ecs_target.value, "group", null)
      launch_type = lookup(ecs_target.value, "launch_type", null)
      dynamic "network_configuration" {
        for_each = lookup(ecs_target.value, "network_configuration", [])
        content {
          subnets          = lookup(network_configuration.value, "subnets", null)
          security_groups  = lookup(network_configuration.value, "security_groups", null)
          assign_public_ip = lookup(network_configuration.value, "assign_public_ip", null)
        }
      }
      platform_version    = lookup(ecs_target.value, "platform_version", null)
      task_count          = lookup(ecs_target.value, "task_count", null)
      task_definition_arn = lookup(ecs_target.value, "task_definition_arn", null)
    }
  }
  dynamic "batch_target" {
    for_each = var.event_target_batch_target
    content {
      job_definition = lookup(batch_target.value, "job_definition", null)
      job_name       = lookup(batch_target.value, "job_name", null)
      array_size     = lookup(batch_target.value, "array_size", null)
      job_attempts   = lookup(batch_target.value, "job_attempts", null)
    }
  }
  dynamic "kinesis_target" {
    for_each = var.event_target_kinesis_target
    content {
      partition_key_path = lookup(kinesis_target.value, "partition_key_path", null)
    }
  }
  dynamic "sqs_target" {
    for_each = var.event_target_sqs_target
    content {
      message_group_id = lookup(sqs_target.value, "message_group_id", null)
    }
  }
  dynamic "input_transformer" {
    for_each = var.event_target_input_transformer
    content {
      input_paths    = lookup(input_transformer.value, "input_paths", null)
      input_template = lookup(input_transformer.value, "input_template", null)
    }
  }
}
