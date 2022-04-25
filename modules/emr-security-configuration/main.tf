#--------------------------------------------------------------
# EMR Security Configuration
#--------------------------------------------------------------

locals {
  configuration = templatefile(
    "${path.module}/templates/configuration.json.tpl",
    {
      EnableAtRestEncryption    = var.encryption_at_rest,
      AtRestS3EncryptionMode    = var.s3_encryption_at_rest_mode,
      EnableInTransitEncryption = var.encryption_in_transit
    }
  )
}

resource "aws_emr_security_configuration" "this" {
  count         = module.this.enabled ? 1 : 0
  name          = coalesce(var.security_configuration_name, module.this.id)
  name_prefix   = var.name_prefix
  configuration = coalesce(var.configuration, local.configuration)
}
