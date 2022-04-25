#--------------------------------------------------------------
# Labeling
#--------------------------------------------------------------

module "label_master" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, list("master")))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_slave" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, list("slave")))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_core" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, list("core")))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_master_managed" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, list("master", "managed")))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_slave_managed" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, list("slave", "managed")))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "label_service_managed" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, list("service", "managed")))
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

resource "aws_security_group" "managed_master" {
  count                  = module.this.enabled ? 1 : 0
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  name                   = module.label_master_managed.id
  description            = "EmrManagedMasterSecurityGroup"
  tags                   = module.label_master_managed.tags

  # EMR will update "ingress" and "egress" so we ignore the changes here
  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_security_group_rule" "managed_master_egress" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = join("", aws_security_group.managed_master.*.id)
}

resource "aws_security_group" "managed_slave" {
  count                  = module.this.enabled ? 1 : 0
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  name                   = module.label_slave_managed.id
  description            = "EmrManagedSlaveSecurityGroup"
  tags                   = module.label_slave_managed.tags

  # EMR will update "ingress" and "egress" so we ignore the changes here
  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_security_group_rule" "managed_slave_egress" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = join("", aws_security_group.managed_slave.*.id)
}

resource "aws_security_group" "managed_service_access" {
  count                  = module.this.enabled && var.subnet_type == "private" ? 1 : 0
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  name                   = module.label_service_managed.id
  description            = "EmrManagedServiceAccessSecurityGroup"
  tags                   = module.label_service_managed.tags

  # EMR will update "ingress" and "egress" so we ignore the changes here
  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_security_group_rule" "managed_service_access_egress" {
  count             = module.this.enabled && var.subnet_type == "private" ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = join("", aws_security_group.managed_service_access.*.id)
}

resource "aws_security_group_rule" "managed_service_access_ingress" {
  count                    = module.this.enabled && var.subnet_type == "private" ? 1 : 0
  description              = "Allow tcp 9443 ingress traffic from EmrManagedMasterSecurityGroup"
  type                     = "ingress"
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  source_security_group_id = join("", aws_security_group.managed_master.*.id)
  security_group_id        = join("", aws_security_group.managed_service_access.*.id)
}

# Specify additional master and slave security groups
resource "aws_security_group" "master" {
  count                  = module.this.enabled ? 1 : 0
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  name                   = module.label_master.id
  description            = "Allow inbound traffic from Security Groups and CIDRs for masters. Allow all outbound traffic"
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
  security_group_id        = join("", aws_security_group.master.*.id)
}

resource "aws_security_group_rule" "master_ingress_cidr_blocks" {
  count             = module.this.enabled && length(var.master_allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.master_allowed_cidr_blocks
  security_group_id = join("", aws_security_group.master.*.id)
}

resource "aws_security_group_rule" "master_egress" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.master.*.id)
}

resource "aws_security_group" "slave" {
  count                  = module.this.enabled ? 1 : 0
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id
  name                   = module.label_slave.id
  description            = "Allow inbound traffic from Security Groups and CIDRs for slaves. Allow all outbound traffic"
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
  security_group_id        = join("", aws_security_group.slave.*.id)
}

resource "aws_security_group_rule" "slave_ingress_cidr_blocks" {
  count             = module.this.enabled && length(var.slave_allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.slave_allowed_cidr_blocks
  security_group_id = join("", aws_security_group.slave.*.id)
}

resource "aws_security_group_rule" "slave_egress" {
  count             = module.this.enabled ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.slave.*.id)
}
