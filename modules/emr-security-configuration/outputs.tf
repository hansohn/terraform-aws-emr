#--------------------------------------------------------------
# EMR Security COnfiguration
#--------------------------------------------------------------

output "id" {
  value       = join("", aws_emr_security_configuration.this.*.id)
  description = "The ID of the EMR Security Configuration (Same as the name)"
}

output "name" {
  value       = join("", aws_emr_security_configuration.this.*.name)
  description = "The Name of the EMR Security Configuration"
}
