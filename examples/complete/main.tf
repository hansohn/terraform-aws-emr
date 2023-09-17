provider "aws" {
  region = var.region
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

module "vpc" {
  source  = "hansohn/vpc/aws"
  version = ">= 1.0.0, < 2.0.0"
  context = module.this.context
  name    = "vpc"

  # general
  cidr_block                       = "10.0.0.0/22"
  availability_zones               = ["us-west-2a", "us-west-2b"]
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true
  enable_internet_gateway          = true

  # default acls
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

  # public acls
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

  # private acls
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

  # protected acls
  protected_ingress_acl_rules = [
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
  protected_egress_acl_rules = [
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
}

#--------------------------------------------------------------
# IAM
#--------------------------------------------------------------

module "iam" {
  source  = "../../modules/emr-iam"
  context = module.this.context
  enabled = module.this.enabled
  name    = "emr"

  #emr iam
  # emr_iam_policy_name_prefix     = local.emr_policy_name_prefix
  emr_iam_policy_resources      = []
  emr_iam_policy_s3_resources   = []
  emr_iam_full_access_role_name = ""
  # emr_iam_full_access_group_name = dependency.iam_groups.outputs.iam_global_full_access_group_name
}

#--------------------------------------------------------------
# S3
#--------------------------------------------------------------

module "s3" {
  source  = "../../modules/s3-emr"
  context = module.this.context
  enabled = module.this.enabled
  # name = "emr"

  # common
  mini_attrs = false

  # emr admin s3 bucket
  s3_emr_admin_allow_encrypted_uploads_only = false
  s3_emr_admin_force_destroy                = false
  s3_emr_admin_sse_algorithm                = "AES256"

  # emr checkpoints s3 bucket
  s3_emr_checkpoints_allow_encrypted_uploads_only = false
  s3_emr_checkpoints_force_destroy                = false
  s3_emr_checkpoints_sse_algorithm                = "AES256"

  # emr data s3 bucket
  s3_emr_data_allow_encrypted_uploads_only = true
  s3_emr_data_force_destroy                = false
  s3_emr_data_sse_algorithm                = "AES256"

  # emr logs s3 bucket
  s3_emr_logs_force_destroy = false
  s3_emr_logs_sse_algorithm = "AES256"
}

#--------------------------------------------------------------
# EMR
#--------------------------------------------------------------

module "emr" {
  source  = "../../"
  context = module.this.context
  enabled = module.this.enabled
  name    = "emr"

  # vpc
  vpc_id = module.vpc.vpc_id

  # bootstrap
  bootstrap_s3_bucket = module.s3.s3_bucket_emr_admin_id
  bootstrap_s3_key    = "bootstrap-actions/default/envs-config.sh"

  # emr cluster
  applications                           = ["Hadoop", "Livy", "Spark"]
  autoscaling_role                       = module.iam.iam_ec2_autoscaling_role_arn
  core_instance_autoscaling_min_capacity = 1
  core_instance_autoscaling_max_capacity = 10
  core_instance_group_instance_type      = "m5.2xlarge"
  core_instance_group_instance_count     = 1
  core_instance_group_ebs_config_size    = 50
  core_instance_group_ebs_config_type    = "gp2"
  ebs_root_volume_size                   = 10
  # ec2_attributes_key_name = dependency.bastion.outputs.instance_key_name
  ec2_attributes_subnet_id              = module.vpc.private_subnet_ids[0]
  ec2_attributes_instance_profile       = module.iam.iam_ec2_instance_profile_arn
  log_uri                               = "s3n://${module.s3.s3_bucket_emr_logs_id}/"
  master_instance_group_instance_type   = "m5.xlarge"
  master_instance_group_instance_count  = 1
  master_instance_group_ebs_config_size = 20
  master_instance_group_ebs_config_type = "gp2"
  release_label                         = "emr-5.35.0"
  service_role                          = module.iam.iam_emr_assume_role_arn
  step_concurrency_level                = 100
}
