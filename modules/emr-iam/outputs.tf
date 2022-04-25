#--------------------------------------------------------------
# IAM
#--------------------------------------------------------------

# emr full access policy
output "iam_emr_full_access_arn" {
  value       = element(concat(aws_iam_policy.emr_full_access.*.arn, [""]), 0)
  description = "The ARN assigned by AWS to this EMR Put policy."
}

output "iam_emr_full_access_id" {
  value       = element(concat(aws_iam_policy.emr_full_access.*.id, [""]), 0)
  description = "The EMR Put policy ID"
}

# emr assume role 
output "iam_emr_assume_role_arn" {
  value       = element(concat(aws_iam_role.emr_assume_role.*.arn, [""]), 0)
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_emr_assume_role_id" {
  value       = element(concat(aws_iam_role.emr_assume_role.*.id, [""]), 0)
  description = "The id of the role"
}

output "iam_emr_assume_role_name" {
  value       = element(concat(aws_iam_role.emr_assume_role.*.name, [""]), 0)
  description = "The name of the role"
}

output "iam_emr_assume_role_unique_id" {
  value       = element(concat(aws_iam_role.emr_assume_role.*.unique_id, [""]), 0)
  description = "The stable and unique string identifying the role"
}

# emr ec2 assume role 
output "iam_ec2_assume_role_arn" {
  value       = element(concat(aws_iam_role.ec2_assume_role.*.arn, [""]), 0)
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_ec2_assume_role_id" {
  value       = element(concat(aws_iam_role.ec2_assume_role.*.id, [""]), 0)
  description = "The id of the role"
}

output "iam_ec2_assume_role_name" {
  value       = element(concat(aws_iam_role.ec2_assume_role.*.name, [""]), 0)
  description = "The name of the role"
}

output "iam_ec2_assume_role_unique_id" {
  value       = element(concat(aws_iam_role.ec2_assume_role.*.unique_id, [""]), 0)
  description = "The stable and unique string identifying the role"
}

# emr ec2 autoscaling role 
output "iam_ec2_autoscaling_role_arn" {
  value       = element(concat(aws_iam_role.ec2_autoscaling.*.arn, [""]), 0)
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_ec2_autoscaling_role_id" {
  value       = element(concat(aws_iam_role.ec2_autoscaling.*.id, [""]), 0)
  description = "The id of the role"
}

output "iam_ec2_autoscaling_role_name" {
  value       = element(concat(aws_iam_role.ec2_autoscaling.*.name, [""]), 0)
  description = "The name of the role"
}

output "iam_ec2_autoscaling_role_unique_id" {
  value       = element(concat(aws_iam_role.ec2_autoscaling.*.unique_id, [""]), 0)
  description = "The stable and unique string identifying the role"
}

# emr autoscaling role 
output "iam_emr_autoscaling_role_arn" {
  value       = element(concat(aws_iam_role.emr_autoscaling.*.arn, [""]), 0)
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "iam_emr_autoscaling_role_id" {
  value       = element(concat(aws_iam_role.emr_autoscaling.*.id, [""]), 0)
  description = "The id of the role"
}

output "iam_emr_autoscaling_role_name" {
  value       = element(concat(aws_iam_role.emr_autoscaling.*.name, [""]), 0)
  description = "The name of the role"
}

output "iam_emr_autoscaling_role_unique_id" {
  value       = element(concat(aws_iam_role.emr_autoscaling.*.unique_id, [""]), 0)
  description = "The stable and unique string identifying the role"
}

# aws_iam_instance_profile
output "iam_ec2_instance_profile_id" {
  value       = element(concat(aws_iam_instance_profile.ec2.*.id, [""]), 0)
  description = "The instance profile's ID."
}

output "iam_ec2_instance_profile_arn" {
  value       = element(concat(aws_iam_instance_profile.ec2.*.arn, [""]), 0)
  description = "The ARN assigned by AWS to the instance profile."
}

output "iam_ec2_instance_profile_name" {
  value       = element(concat(aws_iam_instance_profile.ec2.*.name, [""]), 0)
  description = "The instance profile's name."
}
