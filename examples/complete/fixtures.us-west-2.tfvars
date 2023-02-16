#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

region = "us-west-2"

namespace = "hansohn"
stage     = "test"
# name      = "emr"

availability_zones               = ["us-west-2a", "us-west-2b"]
cidr_block                       = "10.0.0.0/22"
enable_dns_support               = true
enable_dns_hostnames             = true
assign_generated_ipv6_cidr_block = true
enable_internet_gateway          = true

enable_dynamic_subnets   = true
enable_public_network    = true
enable_protected_network = true
enable_private_network   = true

default_network_acl_ingress = [
  {
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  },
  {
    rule_no         = 101
    action          = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]
default_network_acl_egress = [
  {
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  },
  {
    rule_no         = 101
    action          = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]

public_ingress_acl_rules = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number     = 101
    rule_action     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]
public_egress_acl_rules = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number     = 101
    rule_action     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]

private_ingress_acl_rules = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number     = 101
    rule_action     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]
private_egress_acl_rules = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number     = 101
    rule_action     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]

intra_ingress_acl_rules = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number     = 101
    rule_action     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]
intra_egress_acl_rules = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number     = 101
    rule_action     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]

#--------------------------------------------------------------
# EMR
#--------------------------------------------------------------

# naming convention
enabled = true
name    = "emr"

# vpc security groups
master_allowed_security_groups = list(dependency.bastion.outputs.security_group_id)
slave_allowed_security_groups  = list(dependency.bastion.outputs.security_group_id)
vpc_id                         = dependency.vpc.outputs.vpc_id

# bootstrap
bootstrap_s3_bucket = dependency.storage.outputs.s3_bucket_emr_admin_id
bootstrap_s3_key    = "bootstrap-actions/default/envs-config.sh"

# emr cluster
applications                           = ["Hadoop", "Livy", "Spark"]
autoscaling_role                       = dependency.iam_emr.outputs.iam_ec2_autoscaling_role_arn
core_instance_autoscaling_min_capacity = 1
core_instance_autoscaling_max_capacity = 10
core_instance_group_instance_type      = "m5.2xlarge"
core_instance_group_instance_count     = 1
core_instance_group_ebs_config_size    = 50
core_instance_group_ebs_config_type    = "gp2"
ebs_root_volume_size                   = 10
ec2_attributes_key_name                = dependency.bastion.outputs.instance_key_name
ec2_attributes_subnet_id               = dependency.vpc.outputs.private_subnet_ids[0]
ec2_attributes_instance_profile        = dependency.iam_emr.outputs.iam_ec2_instance_profile_arn
log_uri                                = "s3n://${dependency.storage.outputs.s3_bucket_emr_logs_id}/"
master_instance_group_instance_type    = "m5.xlarge"
master_instance_group_instance_count   = 1
master_instance_group_ebs_config_size  = 20
master_instance_group_ebs_config_type  = "gp2"
release_label                          = "emr-5.30.1"
service_role                           = dependency.iam_emr.outputs.iam_emr_assume_role_arn
step_concurrency_level                 = 100

# cloudwatch event target
sns_topic_arn = dependency.notifications.outputs.sns_topic_notifications_arn

