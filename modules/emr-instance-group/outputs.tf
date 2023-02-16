#--------------------------------------------------------------
# EMR Instance Group
#--------------------------------------------------------------

output "id" {
  value       = element(concat(aws_emr_instance_group.this[*].id, [""]), 0)
  description = "The EMR Instance ID"
}

output "running_instance_count" {
  value       = element(concat(aws_emr_instance_group.this[*].running_instance_count, [""]), 0)
  description = "The number of instances currently running in this instance group."
}

output "status" {
  value       = element(concat(aws_emr_instance_group.this[*].status, [""]), 0)
  description = "The current status of the instance group."
}
