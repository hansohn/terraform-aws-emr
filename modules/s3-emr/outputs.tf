#--------------------------------------------------------------
# S3
#--------------------------------------------------------------

# s3 bucket emr admin
output "s3_bucket_emr_admin_arn" {
  value       = module.s3_bucket_emr_admin.bucket_arn
  description = "The ARN of the 's3_bucket_emr_admin' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_admin_id" {
  value       = module.s3_bucket_emr_admin.bucket_id
  description = "The name of the 's3_bucket_emr_admin' bucket."
}

# s3 bucket emr checkpoints
output "s3_bucket_emr_checkpoints_arn" {
  value       = module.s3_bucket_emr_checkpoints.bucket_arn
  description = "The ARN of the 's3_bucket_emr_checkpoints' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_checkpoints_id" {
  value       = module.s3_bucket_emr_checkpoints.bucket_id
  description = "The name of the 's3_bucket_emr_checkpoints' bucket."
}

# s3 bucket emr data
output "s3_bucket_emr_data_arn" {
  value       = module.s3_bucket_emr_data.bucket_arn
  description = "The ARN of the 's3_bucket_emr_data' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_data_id" {
  value       = module.s3_bucket_emr_data.bucket_id
  description = "The name of the 's3_bucket_emr_data' bucket."
}

# s3 bucket emr logs
output "s3_bucket_emr_logs_arn" {
  value       = module.s3_bucket_emr_logs.bucket_arn
  description = "The ARN of the 's3_bucket_emr_logs' bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_emr_logs_id" {
  value       = module.s3_bucket_emr_logs.bucket_id
  description = "The name of the 's3_bucket_emr_logs' bucket."
}
