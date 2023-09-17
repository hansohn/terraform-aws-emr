#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

output "vpc_arn" {
  value       = module.vpc.vpc_arn
  description = "Amazon Resource Name (ARN) of VPC"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC"
}

output "vpc_instance_tenancy" {
  value       = module.vpc.vpc_instance_tenancy
  description = "Tenancy of instances spin up within VPC."
}

output "vpc_enable_dns_support" {
  value       = module.vpc.vpc_enable_dns_support
  description = "Whether or not the VPC has DNS support"
}

output "vpc_enable_dns_hostnames" {
  value       = module.vpc.vpc_enable_dns_hostnames
  description = "Whether or not the VPC has DNS hostname support"
}

output "vpc_main_route_table_id" {
  value       = module.vpc.vpc_main_route_table_id
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association."
}

output "vpc_default_network_acl_id" {
  value       = module.vpc.vpc_default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation"
}

output "vpc_default_security_group_id" {
  value       = module.vpc.vpc_default_security_group_id
  description = "The ID of the security group created by default on VPC creation"
}

output "vpc_default_route_table_id" {
  value       = module.vpc.vpc_default_route_table_id
  description = "The ID of the route table created by default on VPC creation"
}

output "vpc_ipv6_association_id" {
  value       = module.vpc.vpc_ipv6_association_id
  description = "The association ID for the IPv6 CIDR block."
}

output "vpc_ipv6_cidr_block" {
  value       = module.vpc.vpc_ipv6_cidr_block
  description = "The IPv6 CIDR block."
}

output "vpc_owner_id" {
  value       = module.vpc.vpc_owner_id
  description = "The ID of the AWS account that owns the VPC."
}

#--------------------------------------------------------------
# Default Network ACL
#--------------------------------------------------------------

output "default_network_acl_id" {
  value       = module.vpc.default_network_acl_id
  description = "The ID of the Default Network ACL"
}

output "default_network_acl_arn" {
  value       = module.vpc.default_network_acl_arn
  description = "The ARN of the Default Network ACL"
}

output "default_network_acl_vpc_id" {
  value       = module.vpc.default_network_acl_vpc_id
  description = "The ID of the associated VPC"
}

output "default_network_acl_subnet_ids" {
  value       = module.vpc.default_network_acl_subnet_ids
  description = "IDs of associated Subnets"
}

output "default_network_acl_owner_id" {
  value       = module.vpc.default_network_acl_owner_id
  description = "The ID of the AWS account that owns the Default Network ACL"
}

#--------------------------------------------------------------
# Default Security Group
#--------------------------------------------------------------

output "default_security_group_id" {
  value       = module.vpc.default_security_group_id
  description = "The ID of the security group"
}

output "default_security_group_arn" {
  value       = module.vpc.default_security_group_arn
  description = "The ARN of the security group"
}

output "default_security_group_vpc_id" {
  value       = module.vpc.default_security_group_vpc_id
  description = "The VPC ID."
}

output "default_security_group_owner_id" {
  value       = module.vpc.default_security_group_owner_id
  description = "The owner ID."
}

output "default_security_group_name" {
  value       = module.vpc.default_security_group_name
  description = "The name of the security group"
}

output "default_security_group_description" {
  value       = module.vpc.default_security_group_description
  description = "The description of the security group"
}

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------

output "igw_id" {
  value       = module.vpc.igw_id
  description = "The ID of the Internet Gateway."
}

output "igw_arn" {
  value       = module.vpc.igw_arn
  description = "The ARN of the Internet Gateway."
}

output "igw_owner_id" {
  value       = module.vpc.igw_owner_id
  description = "The ID of the AWS account that owns the internet gateway."
}

#--------------------------------------------------------------
# Availability Zones
#--------------------------------------------------------------

output "availability_zones" {
  value       = module.vpc.availability_zones
  description = "List of utilized availability zones"
}

#--------------------------------------------------------------
# Public Subnet
#--------------------------------------------------------------

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "The IDs of the Public subnets"
}

output "public_subnet_arns" {
  value       = module.vpc.public_subnet_arns
  description = "The ARNs of the Public subnets."
}

output "public_subnet_cidr_blocks" {
  value       = module.vpc.public_subnet_cidr_blocks
  description = "The CIDR blocks of the created Public subnets"
}

output "public_subnet_ipv6_cidr_block_association_ids" {
  value       = module.vpc.public_subnet_ipv6_cidr_block_association_ids
  description = "The association IDs for the IPv6 CIDR blocks of the Public subnets."
}

output "public_subnet_owner_ids" {
  value       = module.vpc.public_subnet_owner_ids
  description = "The ID of the AWS account that owns the Public subnets."
}

#--------------------------------------------------------------
# Public Route Table
#--------------------------------------------------------------

output "public_route_table_id" {
  value       = module.vpc.public_route_table_id
  description = "The ID of the Public routing table."
}

output "public_route_table_owner_id" {
  value       = module.vpc.public_route_table_owner_id
  description = "The ID of the AWS account that owns the Public route table."
}

#--------------------------------------------------------------
# Protected Subnet
#--------------------------------------------------------------

output "protected_subnet_ids" {
  value       = module.vpc.protected_subnet_ids
  description = "The IDs of the Protected subnets"
}

output "protected_subnet_arns" {
  value       = module.vpc.protected_subnet_arns
  description = "The ARNs of the Protected subnets."
}

output "protected_subnet_cidr_blocks" {
  value       = module.vpc.protected_subnet_cidr_blocks
  description = "The CIDR blocks of the created Protected subnets"
}

output "protected_subnet_ipv6_cidr_block_association_ids" {
  value       = module.vpc.protected_subnet_ipv6_cidr_block_association_ids
  description = "The association IDs for the IPv6 CIDR blocks of the Protected subnets."
}

output "protected_subnet_owner_ids" {
  value       = module.vpc.protected_subnet_owner_ids
  description = "The ID of the AWS account that owns the Protected subnets."
}

#--------------------------------------------------------------
# Protected Route Table
#--------------------------------------------------------------

output "protected_route_table_ids" {
  value       = module.vpc.protected_route_table_ids
  description = "The ID of the Protected routing table."
}

output "protected_route_table_owner_ids" {
  value       = module.vpc.protected_route_table_owner_ids
  description = "The ID of the AWS account that owns the Protected route table."
}

#--------------------------------------------------------------
# Private Subnet
#--------------------------------------------------------------

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "The IDs of the Private subnets"
}

output "private_subnet_arns" {
  value       = module.vpc.private_subnet_arns
  description = "The ARNs of the Private subnets."
}

output "private_subnet_cidr_blocks" {
  value       = module.vpc.private_subnet_cidr_blocks
  description = "The CIDR blocks of the created Private subnets"
}

output "private_subnet_ipv6_cidr_block_association_ids" {
  value       = module.vpc.private_subnet_ipv6_cidr_block_association_ids
  description = "The association IDs for the IPv6 CIDR blocks of the Private subnets."
}

output "private_subnet_owner_ids" {
  value       = module.vpc.private_subnet_owner_ids
  description = "The ID of the AWS account that owns the Private subnets."
}

#--------------------------------------------------------------
# Private Route Table
#--------------------------------------------------------------

output "private_route_table_id" {
  value       = module.vpc.private_route_table_id
  description = "The ID of the Private routing table."
}

output "private_route_table_owner_id" {
  value       = module.vpc.private_route_table_owner_id
  description = "The ID of the AWS account that owns the Private route table."
}

#--------------------------------------------------------------
# IAM
#--------------------------------------------------------------

# emr full access policy
output "iam_emr_full_access_arn" {
  value       = module.iam.iam_emr_full_access_arn
  description = "The ARN assigned by AWS to this EMR Put policy."
}

output "iam_emr_full_access_id" {
  value       = module.iam.iam_emr_full_access_id
  description = "The EMR Put policy ID"
}

# emr assume role
output "iam_emr_assume_role_arn" {
  value       = module.iam.iam_emr_assume_role_arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_emr_assume_role_id" {
  value       = module.iam.iam_emr_assume_role_id
  description = "The id of the role"
}

output "iam_emr_assume_role_name" {
  value       = module.iam.iam_emr_assume_role_name
  description = "The name of the role"
}

output "iam_emr_assume_role_unique_id" {
  value       = module.iam.iam_emr_assume_role_unique_id
  description = "The stable and unique string identifying the role"
}

# emr ec2 assume role
output "iam_ec2_assume_role_arn" {
  value       = module.iam.iam_ec2_assume_role_arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_ec2_assume_role_id" {
  value       = module.iam.iam_ec2_assume_role_id
  description = "The id of the role"
}

output "iam_ec2_assume_role_name" {
  value       = module.iam.iam_ec2_assume_role_name
  description = "The name of the role"
}

output "iam_ec2_assume_role_unique_id" {
  value       = module.iam.iam_ec2_assume_role_unique_id
  description = "The stable and unique string identifying the role"
}

# emr ec2 autoscaling role
output "iam_ec2_autoscaling_role_arn" {
  value       = module.iam.iam_ec2_autoscaling_role_arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_ec2_autoscaling_role_id" {
  value       = module.iam.iam_ec2_autoscaling_role_id
  description = "The id of the role"
}

output "iam_ec2_autoscaling_role_name" {
  value       = module.iam.iam_ec2_autoscaling_role_name
  description = "The name of the role"
}

output "iam_ec2_autoscaling_role_unique_id" {
  value       = module.iam.iam_ec2_autoscaling_role_unique_id
  description = "The stable and unique string identifying the role"
}

# emr autoscaling role
output "iam_emr_autoscaling_role_arn" {
  value       = module.iam.iam_emr_autoscaling_role_arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_emr_autoscaling_role_id" {
  value       = module.iam.iam_emr_autoscaling_role_id
  description = "The id of the role"
}

output "iam_emr_autoscaling_role_name" {
  value       = module.iam.iam_emr_autoscaling_role_name
  description = "The name of the role"
}

output "iam_emr_autoscaling_role_unique_id" {
  value       = module.iam.iam_emr_autoscaling_role_unique_id
  description = "The stable and unique string identifying the role"
}

# aws_iam_instance_profile
output "iam_ec2_instance_profile_id" {
  value       = module.iam.iam_ec2_instance_profile_id
  description = "The instance profile's ID."
}

output "iam_ec2_instance_profile_arn" {
  value       = module.iam.iam_ec2_instance_profile_arn
  description = "The ARN assigned by AWS to the instance profile."
}

output "iam_ec2_instance_profile_name" {
  value       = module.iam.iam_ec2_instance_profile_name
  description = "The instance profile's name."
}

#--------------------------------------------------------------
# S3 EMR
#--------------------------------------------------------------

# emr admin bucket
output "s3_bucket_emr_admin_arn" {
  value       = module.s3.s3_bucket_emr_admin_arn
  description = "The ARN of the 's3_bucket_emr_admin' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_admin_id" {
  value       = module.s3.s3_bucket_emr_admin_id
  description = "The name of the 's3_bucket_emr_admin' bucket."
}

# emr checkpoints bucket
output "s3_bucket_emr_checkpoints_arn" {
  value       = module.s3.s3_bucket_emr_checkpoints_arn
  description = "The ARN of the 's3_bucket_emr_checkpoints' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_checkpoints_id" {
  value       = module.s3.s3_bucket_emr_checkpoints_id
  description = "The name of the 's3_bucket_emr_checkpoints' bucket."
}

# emr data bucket
output "s3_bucket_emr_data_arn" {
  value       = module.s3.s3_bucket_emr_data_arn
  description = "The ARN of the 's3_bucket_emr_data' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_data_id" {
  value       = module.s3.s3_bucket_emr_data_id
  description = "The name of the 's3_bucket_emr_data' bucket."
}

# emr logs bucket
output "s3_bucket_emr_logs_arn" {
  value       = module.s3.s3_bucket_emr_logs_arn
  description = "The ARN of the 's3_bucket_emr_logs' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_logs_id" {
  value       = module.s3.s3_bucket_emr_logs_id
  description = "The name of the 's3_bucket_emr_logs' bucket."
}

#--------------------------------------------------------------
# EMR Security Groups
#--------------------------------------------------------------

output "emr_managed_master_security_group_id" {
  value       = module.emr.managed_master_security_group_id
  description = "EMR managed_master security group ID"
}

output "emr_managed_slave_security_group_id" {
  value       = module.emr.managed_slave_security_group_id
  description = "EMR managed_slave security group ID"
}

output "emr_managed_service_access_security_group_id" {
  value       = module.emr.managed_service_access_security_group_id
  description = "EMR managed_service_access security group ID"
}

output "emr_master_security_group_id" {
  value       = module.emr.master_security_group_id
  description = "EMR master security group ID"
}

output "emr_slave_security_group_id" {
  value       = module.emr.slave_security_group_id
  description = "EMR slave security group ID"
}

output "emr_notebook_master_security_group_id" {
  value       = module.emr.notebook_master_security_group_id
  description = "Notebook master security group ID"
}

output "emr_notebook_instance_security_group_id" {
  value       = module.emr.notebook_instance_security_group_id
  description = "Notebook instance security group ID"
}

#--------------------------------------------------------------
# EMR Cluster
#--------------------------------------------------------------

output "emr_applications" {
  value       = module.emr.applications
  description = "The applications installed on this cluster."
}

output "emr_arn" {
  value       = module.emr.arn
  description = "The ARN of the cluster."
}

output "emr_bootstrap_action" {
  value       = module.emr.bootstrap_action
  description = "A list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
}

output "emr_configurations" {
  value       = module.emr.configurations
  description = "The list of Configurations supplied to the EMR cluster."
}

output "emr_core_instance_group_0_id" {
  value       = module.emr.core_instance_group_0_id
  description = "Core node type Instance Group ID, if using Instance Group for this node type."
}

output "emr_ec2_attributes" {
  value       = module.emr.ec2_attributes
  description = "Provides information about the EC2 instances in a cluster grouped by category: key name, subnet ID, IAM instance profile, and so on."
}

output "emr_id" {
  value       = module.emr.id
  description = "The ID of the EMR Cluster"
}

output "emr_log_uri" {
  value       = module.emr.log_uri
  description = "The path to the Amazon S3 location where logs for this cluster are stored."
}

output "emr_master_instance_group_0_id" {
  value       = module.emr.master_instance_group_0_id
  description = "Master node type Instance Group ID, if using Instance Group for this node type."
}

output "emr_master_public_dns" {
  value       = module.emr.master_public_dns
  description = "The public DNS name of the master EC2 instance."
}

output "emr_name" {
  value       = module.emr.name
  description = "The name of the cluster."
}

output "emr_release_label" {
  value       = module.emr.release_label
  description = "The release label for the Amazon EMR release."
}

output "emr_service_role" {
  value       = module.emr.service_role
  description = "The IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf."
}

output "emr_visible_to_all_users" {
  value       = module.emr.visible_to_all_users
  description = "Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow."
}
