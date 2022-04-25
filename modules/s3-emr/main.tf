#--------------------------------------------------------------
# Common
#--------------------------------------------------------------

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "utils" {
  source  = "cloudposse/utils/aws"
  version = "0.8.1"
}

locals {
  az_map                  = module.utils.region_az_alt_code_maps["to_short"]
  aws_account_id          = data.aws_caller_identity.current.account_id
  aws_region_mini         = local.az_map[data.aws_region.current.name]
  aws_region              = var.mini_attrs ? local.aws_region_mini : data.aws_region.current.name
  aws_replica_region_mini = var.s3_replica_region != null ? local.az_map[var.s3_replica_region] : null
  aws_replica_region      = var.s3_replica_region != null ? var.mini_attrs ? local.aws_replica_region_mini : var.s3_replica_region : null
}

#--------------------------------------------------------------
# S3
#--------------------------------------------------------------

# emr checkpoints bucket
module "s3_bucket_emr_admin" {
  source                       = "cloudposse/s3-bucket/aws"
  version                      = "2.0.0"
  context                      = module.this.context
  enabled                      = module.this.enabled
  attributes                   = compact(concat(module.this.attributes, ["admin", local.aws_account_id, local.aws_region]))
  name                         = coalesce(module.this.name, "emr")
  allow_encrypted_uploads_only = var.s3_emr_admin_allow_encrypted_uploads_only
  force_destroy                = var.s3_emr_admin_force_destroy
  sse_algorithm                = var.s3_emr_admin_sse_algorithm
}

# emr checkpoints bucket
module "s3_bucket_emr_checkpoints" {
  source                       = "cloudposse/s3-bucket/aws"
  version                      = "2.0.0"
  context                      = module.this.context
  enabled                      = module.this.enabled
  attributes                   = compact(concat(module.this.attributes, ["checkpoints", local.aws_account_id, local.aws_region]))
  name                         = coalesce(module.this.name, "emr")
  allow_encrypted_uploads_only = var.s3_emr_checkpoints_allow_encrypted_uploads_only
  force_destroy                = var.s3_emr_checkpoints_force_destroy
  sse_algorithm                = var.s3_emr_checkpoints_sse_algorithm
}

# emr data bucket
module "s3_bucket_emr_data" {
  source                       = "cloudposse/s3-bucket/aws"
  version                      = "2.0.0"
  context                      = module.this.context
  enabled                      = module.this.enabled
  attributes                   = compact(concat(module.this.attributes, ["data", local.aws_account_id, local.aws_region]))
  name                         = coalesce(module.this.name, "emr")
  allow_encrypted_uploads_only = var.s3_emr_data_allow_encrypted_uploads_only
  force_destroy                = var.s3_emr_data_force_destroy
  sse_algorithm                = var.s3_emr_data_sse_algorithm
}

# emr log bucket
module "s3_bucket_emr_logs" {
  source        = "cloudposse/s3-log-storage/aws"
  version       = "0.28.0"
  context       = module.this.context
  enabled       = module.this.enabled
  attributes    = compact(concat(module.this.attributes, ["logs", local.aws_account_id, local.aws_region]))
  name          = coalesce(module.this.name, "emr")
  force_destroy = var.s3_emr_logs_force_destroy
  sse_algorithm = var.s3_emr_logs_sse_algorithm
}
