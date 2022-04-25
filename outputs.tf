#--------------------------------------------------------------
# Security Groups
#--------------------------------------------------------------

output "managed_master_security_group_id" {
  value       = element(concat(aws_security_group.managed_master.*.id, [""]), 0)
  description = "EMR managed_master security group ID"
}

output "managed_slave_security_group_id" {
  value       = element(concat(aws_security_group.managed_slave.*.id, [""]), 0)
  description = "EMR managed_slave security group ID"
}

output "managed_service_access_security_group_id" {
  value       = element(concat(aws_security_group.managed_service_access.*.id, [""]), 0)
  description = "EMR managed_service_access security group ID"
}

output "master_security_group_id" {
  value       = element(concat(aws_security_group.master.*.id, [""]), 0)
  description = "EMR master security group ID"
}

output "slave_security_group_id" {
  value       = element(concat(aws_security_group.slave.*.id, [""]), 0)
  description = "EMR slave security group ID"
}

output "notebook_master_security_group_id" {
  value       = element(concat(aws_security_group.notebook_master.*.id, [""]), 0)
  description = "Notebook master security group ID"
}

output "notebook_instance_security_group_id" {
  value       = element(concat(aws_security_group.notebook_instance.*.id, [""]), 0)
  description = "Notebook instance security group ID"
}

#--------------------------------------------------------------
# EMR Cluster
#--------------------------------------------------------------

output "applications" {
  value       = module.emr_cluster.applications
  description = "The applications installed on this cluster."
}

output "arn" {
  value       = module.emr_cluster.arn
  description = "The ARN of the cluster."
}

output "bootstrap_action" {
  value       = module.emr_cluster.bootstrap_action
  description = "A list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
}

output "configurations" {
  value       = module.emr_cluster.configurations
  description = "The list of Configurations supplied to the EMR cluster."
}

output "core_instance_group_0_id" {
  value       = module.emr_cluster.core_instance_group_0_id
  description = "Core node type Instance Group ID, if using Instance Group for this node type."
}

output "ec2_attributes" {
  value       = module.emr_cluster.ec2_attributes
  description = "Provides information about the EC2 instances in a cluster grouped by category: key name, subnet ID, IAM instance profile, and so on."
}

output "id" {
  value       = module.emr_cluster.id
  description = "The ID of the EMR Cluster"
}

output "log_uri" {
  value       = module.emr_cluster.log_uri
  description = "The path to the Amazon S3 location where logs for this cluster are stored."
}

output "master_instance_group_0_id" {
  value       = module.emr_cluster.master_instance_group_0_id
  description = "Master node type Instance Group ID, if using Instance Group for this node type."
}

output "master_public_dns" {
  value       = module.emr_cluster.master_public_dns
  description = "The public DNS name of the master EC2 instance."
}

output "name" {
  value       = module.emr_cluster.name
  description = "The name of the cluster."
}

output "release_label" {
  value       = module.emr_cluster.release_label
  description = "The release label for the Amazon EMR release."
}

output "service_role" {
  value       = module.emr_cluster.service_role
  description = "The IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf."
}

output "visible_to_all_users" {
  value       = module.emr_cluster.visible_to_all_users
  description = "Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow."
}
