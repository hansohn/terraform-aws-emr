#--------------------------------------------------------------
# EMR Cluster
#--------------------------------------------------------------

resource "aws_emr_cluster" "this" {
  count            = module.this.enabled ? 1 : 0
  additional_info  = var.additional_info
  applications     = var.applications
  autoscaling_role = var.autoscaling_role
  dynamic "auto_termination_policy" {
    for_each = var.auto_termination_policy
    content {
      idle_timeout = lookup(auto_termination_policy.value, "idle_timeout", null)
    }
  }
  dynamic "bootstrap_action" {
    for_each = var.bootstrap_action
    content {
      name = lookup(bootstrap_action.value, "name", null)
      path = lookup(bootstrap_action.value, "path", null)
      args = lookup(bootstrap_action.value, "args", null)
    }
  }
  configurations      = var.configurations
  configurations_json = var.configurations_json
  dynamic "core_instance_fleet" {
    for_each = var.core_instance_fleet
    content {
      dynamic "instance_type_configs" {
        for_each = lookup(core_instance_fleet.value, "instance_type_configs", [])
        content {
          bid_price                                  = lookup(instance_type_configs.value, "bid_price", null)
          bid_price_as_percentage_of_on_demand_price = lookup(instance_type_configs.value, "bid_price_as_percentage_of_on_demand_price", null)
          dynamic "configurations" {
            for_each = lookup(instance_type_configs.value, "configurations", [])
            content {
              classification = lookup(configurations.value, "classification", null)
              properties     = lookup(configurations.value, "properties", null)
            }
          }
          dynamic "ebs_config" {
            for_each = lookup(instance_type_configs.value, "ebs_config", [])
            content {
              iops                 = lookup(ebs_config.value, "iops", null)
              size                 = lookup(ebs_config.value, "size", null)
              type                 = lookup(ebs_config.value, "type", null)
              volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
            }
          }
          instance_type     = lookup(instance_type_configs.value, "instance_type", null)
          weighted_capacity = lookup(instance_type_configs.value, "weighted_capacity", null)
        }
      }
      dynamic "launch_specifications" {
        for_each = lookup(core_instance_fleet.value, "launch_specifications", [])
        content {
          dynamic "on_demand_specification" {
            for_each = lookup(launch_specifications.value, "on_demand_specification", [])
            content {
              allocation_strategy = lookup(on_demand_specification.value, "allocation_strategy", null)
            }
          }
          dynamic "spot_specification" {
            for_each = lookup(launch_specifications.value, "spot_specification", [])
            content {
              allocation_strategy      = lookup(spot_specification.value, "allocation_strategy", null)
              block_duration_minutes   = lookup(spot_specification.value, "block_duration_minutes", null)
              timeout_action           = lookup(spot_specification.value, "timeout_action", null)
              timeout_duration_minutes = lookup(spot_specification.value, "timeout_duration_minutes", null)
            }
          }
        }
      }
      name                      = lookup(core_instance_fleet.value, "name", null)
      target_on_demand_capacity = lookup(core_instance_fleet.value, "target_on_demand_capacity", null)
      target_spot_capacity      = lookup(core_instance_fleet.value, "target_spot_capacity", null)
    }
  }
  dynamic "core_instance_group" {
    for_each = var.core_instance_group
    content {
      autoscaling_policy = lookup(core_instance_group.value, "autoscaling_policy", null)
      bid_price          = lookup(core_instance_group.value, "bid_price", null)
      dynamic "ebs_config" {
        for_each = lookup(core_instance_group.value, "ebs_config", [])
        content {
          iops                 = lookup(ebs_config.value, "iops", null)
          size                 = lookup(ebs_config.value, "size", null)
          type                 = lookup(ebs_config.value, "type", null)
          volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
        }
      }
      instance_count = lookup(core_instance_group.value, "instance_count", null)
      instance_type  = lookup(core_instance_group.value, "instance_type", null)
      name           = lookup(core_instance_group.value, "name", null)
    }
  }
  custom_ami_id        = var.custom_ami_id
  ebs_root_volume_size = var.ebs_root_volume_size
  dynamic "ec2_attributes" {
    for_each = var.ec2_attributes
    content {
      additional_master_security_groups = lookup(ec2_attributes.value, "additional_master_security_groups", null)
      additional_slave_security_groups  = lookup(ec2_attributes.value, "additional_slave_security_groups", null)
      emr_managed_master_security_group = lookup(ec2_attributes.value, "emr_managed_master_security_group", null)
      emr_managed_slave_security_group  = lookup(ec2_attributes.value, "emr_managed_slave_security_group", null)
      instance_profile                  = lookup(ec2_attributes.value, "instance_profile", null)
      key_name                          = lookup(ec2_attributes.value, "key_name", null)
      service_access_security_group     = lookup(ec2_attributes.value, "service_access_security_group", null)
      subnet_id                         = lookup(ec2_attributes.value, "subnet_id", null)
      subnet_ids                        = lookup(ec2_attributes.value, "subnet_ids", null)
    }
  }
  keep_job_flow_alive_when_no_steps = var.keep_job_flow_alive_when_no_steps
  dynamic "kerberos_attributes" {
    for_each = var.kerberos_attributes
    content {
      ad_domain_join_password              = lookup(kerberos_attributes.value, "ad_domain_join_password", null)
      ad_domain_join_user                  = lookup(kerberos_attributes.value, "ad_domain_join_user", null)
      cross_realm_trust_principal_password = lookup(kerberos_attributes.value, "cross_realm_trust_principal_password", null)
      kdc_admin_password                   = lookup(kerberos_attributes.value, "kdc_admin_password", null)
      realm                                = lookup(kerberos_attributes.value, "realm", null)
    }
  }
  log_encryption_kms_key_id = var.log_encryption_kms_key_id
  log_uri                   = var.log_uri
  dynamic "master_instance_fleet" {
    for_each = var.master_instance_fleet
    content {
      dynamic "instance_type_configs" {
        for_each = lookup(master_instance_fleet.value, "instance_type_configs", [])
        content {
          bid_price                                  = lookup(instance_type_configs.value, "bid_price", null)
          bid_price_as_percentage_of_on_demand_price = lookup(instance_type_configs.value, "bid_price_as_percentage_of_on_demand_price", null)
          dynamic "configurations" {
            for_each = lookup(instance_type_configs.value, "configurations", [])
            content {
              classification = lookup(configurations.value, "classification", null)
              properties     = lookup(configurations.value, "properties", null)
            }
          }
          dynamic "ebs_config" {
            for_each = lookup(instance_type_configs.value, "ebs_config", [])
            content {
              iops                 = lookup(ebs_config.value, "iops", null)
              size                 = lookup(ebs_config.value, "size", null)
              type                 = lookup(ebs_config.value, "type", null)
              volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
            }
          }
          instance_type     = lookup(instance_type_configs.value, "instance_type", null)
          weighted_capacity = lookup(instance_type_configs.value, "weighted_capacity", null)
        }
      }
      dynamic "launch_specifications" {
        for_each = lookup(master_instance_fleet.value, "launch_specifications", [])
        content {
          dynamic "on_demand_specification" {
            for_each = lookup(launch_specifications.value, "on_demand_specification", [])
            content {
              allocation_strategy = lookup(on_demand_specification.value, "allocation_strategy", null)
            }
          }
          dynamic "spot_specification" {
            for_each = lookup(launch_specifications.value, "spot_specification", [])
            content {
              allocation_strategy      = lookup(spot_specification.value, "allocation_strategy", null)
              block_duration_minutes   = lookup(spot_specification.value, "block_duration_minutes", null)
              timeout_action           = lookup(spot_specification.value, "timeout_action", null)
              timeout_duration_minutes = lookup(spot_specification.value, "timeout_duration_minutes", null)
            }
          }
        }
      }
      name                      = lookup(master_instance_fleet.value, "name", null)
      target_on_demand_capacity = lookup(master_instance_fleet.value, "target_on_demand_capacity", null)
      target_spot_capacity      = lookup(master_instance_fleet.value, "target_spot_capacity", null)
    }
  }
  dynamic "master_instance_group" {
    for_each = var.master_instance_group
    content {
      bid_price = lookup(master_instance_group.value, "bid_price", null)
      dynamic "ebs_config" {
        for_each = lookup(master_instance_group.value, "ebs_config", [])
        content {
          iops                 = lookup(ebs_config.value, "iops", null)
          size                 = lookup(ebs_config.value, "size", null)
          type                 = lookup(ebs_config.value, "type", null)
          volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
        }
      }
      instance_count = lookup(master_instance_group.value, "instance_count", null)
      instance_type  = lookup(master_instance_group.value, "instance_type", null)
      name           = lookup(master_instance_group.value, "name", null)
    }
  }
  name                   = coalesce(var.cluster_name, module.this.id)
  release_label          = var.release_label
  scale_down_behavior    = var.scale_down_behavior
  security_configuration = var.security_configuration
  service_role           = var.service_role
  dynamic "step" {
    for_each = var.step
    content {
      action_on_failure = lookup(step.value, "action_on_failure", null)
      dynamic "hadoop_jar_step" {
        for_each = lookup(step.value, "hadoop_jar_step", [])
        content {
          args       = lookup(hadoop_jar_step.value, "args", null)
          jar        = lookup(hadoop_jar_step.value, "jar", null)
          main_class = lookup(hadoop_jar_step.value, "main_class", null)
          properties = lookup(hadoop_jar_step.value, "properties", null)
        }
      }
      name = lookup(step.value, "name", null)
    }
  }
  step_concurrency_level = var.step_concurrency_level
  tags                   = module.this.tags
  termination_protection = var.termination_protection
  visible_to_all_users   = var.visible_to_all_users

  lifecycle {
    ignore_changes = [
      configurations_json,
      core_instance_fleet,
      core_instance_group,
      kerberos_attributes,
      step,
      step_concurrency_level
    ]
  }
}
