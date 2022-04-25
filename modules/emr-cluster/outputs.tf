#--------------------------------------------------------------
# EMR Cluster
#--------------------------------------------------------------

output "applications" {
  value       = element(concat(aws_emr_cluster.this.*.applications, [""]), 0)
  description = "The applications installed on this cluster."
}

output "arn" {
  value       = element(concat(aws_emr_cluster.this.*.arn, [""]), 0)
  description = "The ARN of the cluster."
}

output "bootstrap_action" {
  value       = element(concat(aws_emr_cluster.this.*.bootstrap_action, [""]), 0)
  description = "A list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
}

output "configurations" {
  value       = element(concat(aws_emr_cluster.this.*.configurations, [""]), 0)
  description = "The list of Configurations supplied to the EMR cluster."
}

output "core_instance_group_0_id" {
  value       = element(concat(aws_emr_cluster.this.*.core_instance_group.0.id, [""]), 0)
  description = "Core node type Instance Group ID, if using Instance Group for this node type."
}

output "ec2_attributes" {
  value       = element(concat(aws_emr_cluster.this.*.ec2_attributes, [""]), 0)
  description = "Provides information about the EC2 instances in a cluster grouped by category: key name, subnet ID, IAM instance profile, and so on."
}

output "id" {
  value       = element(concat(aws_emr_cluster.this.*.id, [""]), 0)
  description = "The ID of the EMR Cluster"
}

output "log_uri" {
  value       = element(concat(aws_emr_cluster.this.*.log_uri, [""]), 0)
  description = "The path to the Amazon S3 location where logs for this cluster are stored."
}

output "master_instance_group_0_id" {
  value       = element(concat(aws_emr_cluster.this.*.master_instance_group.0.id, [""]), 0)
  description = "Master node type Instance Group ID, if using Instance Group for this node type."
}

output "master_public_dns" {
  value       = element(concat(aws_emr_cluster.this.*.master_public_dns, [""]), 0)
  description = "The public DNS name of the master EC2 instance."
}

output "name" {
  value       = element(concat(aws_emr_cluster.this.*.name, [""]), 0)
  description = "The name of the cluster."
}

output "release_label" {
  value       = element(concat(aws_emr_cluster.this.*.release_label, [""]), 0)
  description = "The release label for the Amazon EMR release."
}

output "service_role" {
  value       = element(concat(aws_emr_cluster.this.*.service_role, [""]), 0)
  description = "The IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf."
}

output "tags_all" {
  value       = element(concat(aws_emr_cluster.this.*.tags_all, [""]), 0)
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "visible_to_all_users" {
  value       = element(concat(aws_emr_cluster.this.*.visible_to_all_users, [""]), 0)
  description = "Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow."
}
