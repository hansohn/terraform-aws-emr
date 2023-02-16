#--------------------------------------------------------------
# Cloudwatch Event Rule
#--------------------------------------------------------------

output "arn" {
  value       = element(concat(aws_cloudwatch_event_rule.this[*].arn, [""]), 0)
  description = "The Amazon Resource Name (ARN) of the rule."
}

output "id" {
  value       = element(concat(aws_cloudwatch_event_rule.this[*].id, [""]), 0)
  description = "The name of the rule."
}

output "name" {
  value       = element(concat(aws_cloudwatch_event_rule.this[*].name, [""]), 0)
  description = "The rule's name."
}


