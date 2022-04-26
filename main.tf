data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  aws_region = data.aws_region.current.name
}

data "aws_prefix_list" "s3" {
  name = "com.amazonaws.${local.aws_region}.s3"
}

#--------------------------------------------------------------
# Labeling
#--------------------------------------------------------------

module "label_master" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["master"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_slave" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["slave"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_core" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["core"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_master_managed" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["master", "managed"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_slave_managed" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["slave", "managed"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_service_managed" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["service", "managed"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_notebook_master" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["notebook", "master"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_notebook_instance" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["notebook", "instance"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_cloudwatch_rule" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.this.context
  enabled = module.this.enabled
}

module "label_cloudwatch_target" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["sns"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

#--------------------------------------------------------------
# Security Groups
#--------------------------------------------------------------

/*
NOTE on EMR-Managed security groups: These security groups will have any missing inbound or outbound access rules added and maintained by AWS,
to ensure proper communication between instances in a cluster. The EMR service will maintain these rules for groups provided
in emr_managed_master_security_group and emr_managed_slave_security_group;
attempts to remove the required rules may succeed, only for the EMR service to re-add them in a matter of minutes.
This may cause Terraform to fail to destroy an environment that contains an EMR cluster, because the EMR service does not revoke rules added on deletion,
leaving a cyclic dependency between the security groups that prevents their deletion.
To avoid this, use the revoke_rules_on_delete optional attribute for any Security Group used in
emr_managed_master_security_group and emr_managed_slave_security_group.
*/

# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-sg-specify.html
# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-man-sec-groups.html
# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-clusters-in-a-vpc.html

# emr-managed security group for master instance

resource "aws_security_group" "managed_master" {
  count                  = module.this.enabled ? 1 : 0
  name                   = module.label_master_managed.id
  description            = "${replace(module.label_master_managed.id, module.this.delimiter, " ")} Security Group"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  tags                   = module.label_master_managed.tags

  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_security_group_rule" "managed_master_ingress_self" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all ingress traffic from self"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.managed_master[0].id
}

resource "aws_security_group_rule" "managed_master_ingress_managed_slave" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow all ingress traffic from the emr-managed slave security group"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.managed_slave[0].id
  security_group_id        = aws_security_group.managed_master[0].id
}

resource "aws_security_group_rule" "managed_master_ingress_managed_service" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow tcp 8443 ingress traffic from the emr-managed service security group"
  type                     = "ingress"
  from_port                = "tcp"
  to_port                  = "tcp"
  protocol                 = 8443
  source_security_group_id = aws_security_group.managed_service_access[0].id
  security_group_id        = aws_security_group.managed_master[0].id
}

resource "aws_security_group_rule" "managed_master_egress" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow tcp 9443 egress traffic to the emr-managed service security group"
  type                     = "egress"
  from_port                = "tcp"
  to_port                  = "tcp"
  protocol                 = "9443"
  source_security_group_id = aws_security_group.managed_service_access[0].id
  security_group_id        = aws_security_group.managed_master[0].id
}

# resource "aws_security_group_rule" "managed_master_egress" {
#   count             = module.this.enabled ? 1 : 0
#   description       = "Allow all egress traffic"
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.managed_master[0].id
# }

# emr-managed security group for core and task instances

resource "aws_security_group" "managed_slave" {
  count                  = module.this.enabled ? 1 : 0
  name                   = module.label_slave_managed.id
  description            = "${replace(module.label_slave_managed.id, module.this.delimiter, " ")} Security Group"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  tags                   = module.label_slave_managed.tags

  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_security_group_rule" "managed_slave_ingress_self" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all ingress traffic from self"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.managed_slave[0].id
}

resource "aws_security_group_rule" "managed_slave_ingress_managed_master" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow all ingress traffic from the emr-managed master security group"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.managed_slave[0].id
  security_group_id        = aws_security_group.managed_slave[0].id
}

resource "aws_security_group_rule" "managed_slave_ingress_managed_service" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow all ingress traffic from the emr-managed service access security group"
  type                     = "ingress"
  from_port                = "tcp"
  to_port                  = "tcp"
  protocol                 = 8443
  source_security_group_id = aws_security_group.managed_service_access[0].id
  security_group_id        = aws_security_group.managed_slave[0].id
}

resource "aws_security_group_rule" "managed_slave_egress_s3" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all egress traffic to s3 prefix list"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  prefix_list_ids   = [data.aws_prefix_list.s3.id]
  security_group_id = aws_security_group.managed_slave[0].id
}

resource "aws_security_group_rule" "managed_slave_egress_self" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all egress traffic to self"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.managed_slave[0].id
}

resource "aws_security_group_rule" "managed_slave_egress_master" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow all egress traffic to the emr-managed master security group"
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.managed_master[0].id
  security_group_id        = aws_security_group.managed_slave[0].id
}

resource "aws_security_group_rule" "managed_slave_egress_service" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow all egress traffic to the emr-managed service access security group"
  type                     = "egress"
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.managed_service_access[0].id
  security_group_id        = aws_security_group.managed_slave[0].id
}

# resource "aws_security_group_rule" "managed_slave_egress" {
#   count             = module.this.enabled ? 1 : 0
#   description       = "Allow all egress traffic"
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.managed_slave[0].id
# }

# emr-managed security group for service access

resource "aws_security_group" "managed_service_access" {
  count                  = module.this.enabled && var.subnet_type == "private" ? 1 : 0
  name                   = module.label_service_managed.id
  description            = "${replace(module.label_service_managed.id, module.this.delimiter, " ")} Security Group"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  tags                   = module.label_service_managed.tags

  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_security_group_rule" "managed_service_access_ingress" {
  count                    = module.this.enabled && var.subnet_type == "private" ? 1 : 0
  description              = "Allow tcp 9443 ingress traffic from EmrManagedMasterSecurityGroup"
  type                     = "ingress"
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.managed_master[0].id
  security_group_id        = aws_security_group.managed_service_access[0].id
}

resource "aws_security_group_rule" "managed_service_access_egress_managed_master" {
  count                    = module.this.enabled && var.subnet_type == "private" ? 1 : 0
  description              = "Allow tcp 8443 egress traffic to the emr-managed master security group"
  type                     = "egress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.managed_master[0].id
  security_group_id        = aws_security_group.managed_service_access[0].id
}

resource "aws_security_group_rule" "managed_service_access_egress_managed_slave" {
  count                    = module.this.enabled && var.subnet_type == "private" ? 1 : 0
  description              = "Allow tcp 8443 egress traffic to the emr-managed slave security group"
  type                     = "egress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.managed_slave[0].id
  security_group_id        = aws_security_group.managed_service_access[0].id
}

# resource "aws_security_group_rule" "managed_service_access_egress" {
#   count             = module.this.enabled && var.subnet_type == "private" ? 1 : 0
#   description       = "Allow all egress traffic"
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.managed_service_access[0].id
# }

# non-managed security group for master instance

resource "aws_security_group" "master" {
  count                  = module.this.enabled ? 1 : 0
  name                   = module.label_master.id
  description            = "Allow inbound traffic from Security Groups and CIDRs for masters. Allow all outbound traffic"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  tags                   = module.label_master.tags
}

resource "aws_security_group_rule" "master_ingress_security_groups" {
  count                    = module.this.enabled ? length(var.master_allowed_security_groups) : 0
  description              = "Allow inbound traffic from Security Groups"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.master_allowed_security_groups[count.index]
  security_group_id        = aws_security_group.master[0].id
}

resource "aws_security_group_rule" "master_ingress_cidr_blocks" {
  count             = module.this.enabled && length(var.master_allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.master_allowed_cidr_blocks
  security_group_id = aws_security_group.master[0].id
}

resource "aws_security_group_rule" "master_egress_security_groups" {
  count                    = module.this.enabled ? length(var.master_allowed_security_groups) : 0
  description              = "Allow egress traffic to Security Groups"
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.master_allowed_security_groups[count.index]
  security_group_id        = aws_security_group.master[0].id
}

resource "aws_security_group_rule" "master_egress_cidr_blocks" {
  count             = module.this.enabled && length(var.master_allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow egress traffic to CIDR blocks"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.master_allowed_cidr_blocks
  security_group_id = aws_security_group.master[0].id
}

# resource "aws_security_group_rule" "master_egress" {
#   count             = module.this.enabled ? 1 : 0
#   description       = "Allow all egress traffic"
#   type              = "egress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.master[0].id
# }

resource "aws_security_group" "slave" {
  count                  = module.this.enabled ? 1 : 0
  name                   = module.label_slave.id
  description            = "Allow inbound traffic from Security Groups and CIDRs for slaves. Allow all outbound traffic"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  tags                   = module.label_slave.tags
}

resource "aws_security_group_rule" "slave_ingress_security_groups" {
  count                    = module.this.enabled ? length(var.slave_allowed_security_groups) : 0
  description              = "Allow inbound traffic from Security Groups"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.slave_allowed_security_groups[count.index]
  security_group_id        = aws_security_group.slave[0].id
}

resource "aws_security_group_rule" "slave_ingress_cidr_blocks" {
  count             = module.this.enabled && length(var.slave_allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.slave_allowed_cidr_blocks
  security_group_id = aws_security_group.slave[0].id
}

resource "aws_security_group_rule" "slave_egress_security_groups" {
  count                    = module.this.enabled ? length(var.slave_allowed_security_groups) : 0
  description              = "Allow egress traffic to Security Groups"
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.slave_allowed_security_groups[count.index]
  security_group_id        = aws_security_group.slave[0].id
}

resource "aws_security_group_rule" "slave_egress_cidr_blocks" {
  count             = module.this.enabled && length(var.slave_allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow egress traffic to CIDR blocks"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.slave_allowed_cidr_blocks
  security_group_id = aws_security_group.slave[0].id
}

# resource "aws_security_group_rule" "slave_egress" {
#   count             = module.this.enabled ? 1 : 0
#   description       = "Allow all egress traffic"
#   type              = "egress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.slave[0].id
# }

resource "aws_security_group" "notebook_master" {
  count       = module.this.enabled ? 1 : 0
  name        = module.label_notebook_master.id
  description = "Security group that allows editor to connect to EMR cluster"
  vpc_id      = var.vpc_id
  tags        = module.label_notebook_master.tags
}

resource "aws_security_group_rule" "notebook_master_ingress_livy" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow ingress traffic to Livy"
  type                     = "ingress"
  from_port                = 18888
  to_port                  = 18888
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.notebook_instance[0].id
  security_group_id        = aws_security_group.notebook_master[0].id
}

resource "aws_security_group" "notebook_instance" {
  count       = module.this.enabled ? 1 : 0
  name        = module.label_notebook_instance.id
  description = "Security group that allows editor to connect to EMR cluster"
  vpc_id      = var.vpc_id
  tags        = module.label_notebook_instance.tags
}

resource "aws_security_group_rule" "notebook_instance_egress_livy" {
  count                    = module.this.enabled ? 1 : 0
  description              = "Allow egress traffic to Livy"
  type                     = "egress"
  from_port                = 18888
  to_port                  = 18888
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.notebook_master[0].id
  security_group_id        = aws_security_group.notebook_instance[0].id
}

#tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "notebook_instance_egress_https" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow egress traffic to Https"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.notebook_instance[0].id
}

#--------------------------------------------------------------
# AutoScaling
#--------------------------------------------------------------

locals {
  core_instance_group_autoscaling_policy = templatefile(
    "${path.module}/templates/autoscaling_policy.json.tpl",
    {
      autoscaling_min_capacity = var.core_instance_autoscaling_min_capacity,
      autoscaling_max_capacity = var.core_instance_autoscaling_max_capacity
    }
  )
}

#--------------------------------------------------------------
# Configurations
#--------------------------------------------------------------

locals {
  configurations_json_default = templatefile(
    "${path.module}/templates/configurations.json.tpl",
    {}
  )
  configurations_json = var.configurations_json != null ? var.configurations_json : local.configurations_json_default
}

#--------------------------------------------------------------
# Bootstrap
#--------------------------------------------------------------

locals {
  bootstrap_script = templatefile(
    "${path.module}/templates/emr_bootstrap.sh.tpl",
    {
      delimiter      = module.this.delimiter,
      environment    = module.this.environment,
      namespace      = module.this.namespace,
      stage          = module.this.stage,
      aws_region     = local.aws_region,
      aws_account_id = data.aws_caller_identity.current.account_id
    }
  )
}

resource "aws_s3_object" "emr_bootstrap_script" {
  count                  = module.this.enabled ? 1 : 0
  bucket                 = var.bootstrap_s3_bucket
  content                = local.bootstrap_script
  key                    = var.bootstrap_s3_key
  server_side_encryption = var.bootstrap_s3_server_side_encryption
  kms_key_id             = var.bootstrap_s3_server_side_encryption == "aws:kms" ? var.bootstrap_s3_kms_key_id : null
  tags                   = module.this.tags
}

# This dummy bootstrap action is needed because of terraform bug https://github.com/terraform-providers/terraform-provider-aws/issues/12683
# When javax.jdo.option.ConnectionPassword is used in configuration_json then every plan will result in force recreation of EMR cluster.
# To mitigate this issue dummy bootstrap action `echo` was introduced. It is executed with an argument of a hash generated from configuration.
# This in tandem with lifecycle ignore_changes for `configurations_json` will only trigger EMR recreation when hash of configuration will change.

locals {
  bootstrap_action = concat(
    [
      {
        name = "Dummy bootstrap action to prevent EMR cluster recration when configuration_json has parameter javax.jdo.option.ConnectionPassword.",
        path = "file:/bin/echo",
        args = [md5(jsonencode(local.configurations_json))]
      },
      {
        name = "Bootstrap script containing node customizations",
        path = "s3://${var.bootstrap_s3_bucket}/${var.bootstrap_s3_key}",
        args = []
      }
    ],
    var.bootstrap_action
  )
}

#--------------------------------------------------------------
# EMR Security Configuration
#--------------------------------------------------------------

module "emr_security_configuration" {
  source                     = "./modules/emr-security-configuration"
  attributes                 = compact(concat(module.this.attributes, ["encryption", "at", "rest"]))
  context                    = module.this.context
  enabled                    = module.this.enabled
  encryption_at_rest         = true
  encryption_in_transit      = false
  s3_encryption_at_rest_mode = "SSE-S3"
}

#--------------------------------------------------------------
# EMR Step Debugging
#--------------------------------------------------------------

locals {
  step = [
    {
      action_on_failure = "TERMINATE_CLUSTER"
      name              = "Setup Hadoop Debugging"
      hadoop_jar_step = [
        {
          jar  = "command-runner.jar"
          args = ["state-pusher-script"]
        }
      ]
    }
  ]
}

#--------------------------------------------------------------
# EMR Cluster
#--------------------------------------------------------------

module "emr_cluster" {
  source              = "./modules/emr-cluster"
  context             = module.this.context
  enabled             = module.this.enabled
  additional_info     = var.additional_info
  applications        = var.applications
  autoscaling_role    = var.autoscaling_role
  bootstrap_action    = local.bootstrap_action
  cluster_name        = var.cluster_name
  configurations      = var.configurations
  configurations_json = local.configurations_json
  core_instance_group = [
    {
      autoscaling_policy = var.core_instance_group_autoscaling_policy != null ? var.core_instance_group_autoscaling_policy : local.core_instance_group_autoscaling_policy
      ebs_config = [
        {
          iops                 = var.core_instance_group_ebs_config_iops
          size                 = var.core_instance_group_ebs_config_size
          type                 = var.core_instance_group_ebs_config_type
          volumes_per_instance = var.core_instance_group_ebs_config_volumes_per_instance
        }
      ]
      instance_count = var.core_instance_group_instance_count
      instance_type  = var.core_instance_group_instance_type
      name           = module.label_core.id
    }
  ]
  custom_ami_id        = var.custom_ami_id
  ebs_root_volume_size = var.ebs_root_volume_size
  ec2_attributes = [
    {
      additional_master_security_groups = aws_security_group.master[0].id
      additional_slave_security_groups  = aws_security_group.slave[0].id
      emr_managed_master_security_group = aws_security_group.managed_master[0].id
      emr_managed_slave_security_group  = aws_security_group.managed_slave[0].id
      instance_profile                  = var.ec2_attributes_instance_profile
      key_name                          = var.ec2_attributes_key_name
      service_access_security_group     = var.subnet_type == "private" ? aws_security_group.managed_service_access[0].id : null
      subnet_id                         = var.ec2_attributes_subnet_id
    }
  ]
  keep_job_flow_alive_when_no_steps = var.keep_job_flow_alive_when_no_steps
  # kerberos_attributes = [
  #   {
  #     ad_domain_join_password = var.kerberos_attributes_ad_domain_join_password
  #     ad_domain_join_user = var.kerberos_attributes_ad_domain_join_user
  #     cross_realm_trust_principal_password = var.kerberos_attributes_cross_realm_trust_principal_password
  #     kdc_admin_password = var.kerberos_attributes_kdc_admin_password
  #     realm = var.kerberos_attributes_realm
  #   }
  # ]
  log_uri = var.log_uri
  master_instance_group = [
    {
      bid_price = var.master_instance_group_bid_price
      ebs_config = [
        {
          iops                 = var.master_instance_group_ebs_config_iops
          size                 = var.master_instance_group_ebs_config_size
          type                 = var.master_instance_group_ebs_config_type
          volumes_per_instance = var.master_instance_group_ebs_config_volumes_per_instance
        }
      ]
      instance_count = var.master_instance_group_instance_count
      instance_type  = var.master_instance_group_instance_type
      name           = module.label_master.id
    }
  ]
  release_label          = var.release_label
  scale_down_behavior    = var.scale_down_behavior
  security_configuration = module.emr_security_configuration.name
  service_role           = var.service_role
  step                   = length(var.step) != 0 ? var.step : local.step
  step_concurrency_level = var.step_concurrency_level
  termination_protection = var.termination_protection
  visible_to_all_users   = var.visible_to_all_users
}

#--------------------------------------------------------------
# Cloudwatch Events
#-------------------------------------------------------------

locals {
  event_pattern = templatefile(
    "${path.module}/templates/emr_event_pattern.json.tpl",
    { emr_cluster_id = module.emr_cluster.id }
  )
}

# module "cloudwatch_event_rule_emr" {
#   source        = ""
#   context       = module.label_cloudwatch_rule.context
#   enabled       = module.this.enabled
#   event_pattern = local.event_pattern
#   description   = "EMR Cloudwatch Events for Cluster '${module.emr_cluster.id}'"
# }
# 
# module "cloudwatch_event_target_emr_sns" {
#   source  = ""
#   context = module.label_cloudwatch_target.context
#   enabled = module.this.enabled
#   rule    = module.cloudwatch_event_rule_emr.name
#   arn     = var.sns_topic_arn
# }
