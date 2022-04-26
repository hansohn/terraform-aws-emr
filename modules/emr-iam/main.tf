#--------------------------------------------------------------
# IAM
#--------------------------------------------------------------

data "aws_caller_identity" "current" {}

locals {
  aws_account_id        = data.aws_caller_identity.current.account_id
  emr_naming_convention = split(module.this.delimiter, module.this.id)
  # emr_naming_convention       = compact([module.this.namespace, module.this.environment, module.this.stage, module.this.name])
  # emr_wildcard_prefix         = join(module.this.delimiter, local.emr_naming_convention)
  emr_wildcard_arn            = "arn:aws:emr::${local.aws_account_id}:${module.this.id}*"
  emr_wildcard_s3_arn         = "arn:aws:s3:::${module.this.id}*"
  emr_iam_policy_name_root    = join("", [for name in local.emr_naming_convention : title(name)])
  emr_iam_policy_name_prefix  = coalesce(var.emr_iam_policy_name_prefix, local.emr_iam_policy_name_root)
  emr_iam_policy_resources    = coalescelist(var.emr_iam_policy_resources, [local.emr_wildcard_arn])
  emr_iam_policy_s3_resources = coalescelist(var.emr_iam_policy_s3_resources, [local.emr_wildcard_s3_arn])
}

# EMR FullAccess
# vendored from arn:aws:iam::aws:policy/AmazonElasticMapReduceFullAccess
data "aws_iam_policy_document" "emr_full_access" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:*",
      "cloudformation:CreateStack",
      "cloudformation:DescribeStackEvents",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:CancelSpotInstanceRequests",
      "ec2:CreateRoute",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:DeleteRoute",
      "ec2:DeleteTags",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeInstances",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcs",
      "ec2:DescribeRouteTables",
      "ec2:DescribeNetworkAcls",
      "ec2:CreateVpcEndpoint",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:RequestSpotInstances",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "elasticmapreduce:*",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListRoles",
      "iam:PassRole",
      "kms:List*",
      "sdb:*",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["elasticmapreduce.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]
    resources = local.emr_iam_policy_s3_resources
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:PutObjectTagging",
    ]
    resources = formatlist("%s/*", local.emr_iam_policy_s3_resources)
  }
}

resource "aws_iam_policy" "emr_full_access" {
  count  = module.this.enabled ? 1 : 0
  name   = "${local.emr_iam_policy_name_prefix}FullAccess"
  policy = data.aws_iam_policy_document.emr_full_access.json
}

resource "aws_iam_role_policy_attachment" "emr_full_access" {
  count      = module.this.enabled ? 1 : 0
  policy_arn = aws_iam_policy.emr_full_access[0].arn
  role       = coalesce(var.emr_iam_full_access_role_name, aws_iam_role.ec2_assume_role[0].name)
}

resource "aws_iam_group_policy_attachment" "emr_full_access" {
  count      = module.this.enabled && var.emr_iam_full_access_group_name != "" ? 1 : 0
  policy_arn = aws_iam_policy.emr_full_access[0].arn
  group      = var.emr_iam_full_access_group_name
}


# emr assume role
data "aws_iam_policy_document" "emr_assume_role" {
  count = module.this.enabled ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [
        "elasticmapreduce.amazonaws.com",
        "application-autoscaling.amazonaws.com",
      ]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "emr_assume_role" {
  count              = module.this.enabled ? 1 : 0
  name               = "${local.emr_iam_policy_name_prefix}AssumeRole"
  assume_role_policy = data.aws_iam_policy_document.emr_assume_role[0].json
}

# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html
resource "aws_iam_role_policy_attachment" "emr_assume_role" {
  count      = module.this.enabled ? 1 : 0
  role       = aws_iam_role.emr_assume_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

# Application processes that run on top of the Hadoop ecosystem on cluster instances use this role when they call other AWS services.
# For accessing data in Amazon S3 using EMRFS, you can specify different roles to be assumed based on the user or group making the request,
# or on the location of data in Amazon S3.
# This role is required for all clusters.
# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html

# ec2 assume role
data "aws_iam_policy_document" "ec2_assume_role" {
  count = module.this.enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "ec2_assume_role" {
  count              = module.this.enabled ? 1 : 0
  name               = "${local.emr_iam_policy_name_prefix}Ec2AssumeRole"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role[0].json
}

# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html
resource "aws_iam_role_policy_attachment" "ec2_assume_role" {
  count      = module.this.enabled ? 1 : 0
  role       = aws_iam_role.ec2_assume_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

# emr ec2 instance profile
resource "aws_iam_instance_profile" "ec2" {
  count = module.this.enabled ? 1 : 0
  name  = aws_iam_role.ec2_assume_role[0].name
  role  = aws_iam_role.ec2_assume_role[0].name
}

# Allows additional actions for dynamically scaling environments. Required only for clusters that use automatic scaling in Amazon EMR.
# This role is required for all clusters.
# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html

# ec2 autoscaling role
resource "aws_iam_role" "ec2_autoscaling" {
  count              = module.this.enabled ? 1 : 0
  name               = "${local.emr_iam_policy_name_prefix}Ec2AutoscalingRole"
  assume_role_policy = data.aws_iam_policy_document.emr_assume_role[0].json
}

# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html
resource "aws_iam_role_policy_attachment" "ec2_autoscaling" {
  count      = module.this.enabled ? 1 : 0
  role       = aws_iam_role.ec2_autoscaling[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforAutoScalingRole"
}

# autoscaling role
resource "aws_iam_role" "emr_autoscaling" {
  count              = module.this.enabled ? 1 : 0
  name               = "${local.emr_iam_policy_name_prefix}AutoscalingRole"
  assume_role_policy = data.aws_iam_policy_document.emr_assume_role[0].json
}

# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html
resource "aws_iam_role_policy_attachment" "emr_autoscaling" {
  count      = module.this.enabled ? 1 : 0
  role       = aws_iam_role.emr_autoscaling[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforAutoScalingRole"
}

# EmrNotebookAccess
# vendored from arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceEditorsRole
data "aws_iam_policy_document" "emr_editors_role" {
  count = module.this.enabled ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:DescribeSecurityGroups",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:DescribeNetworkInterfaces",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ec2:DescribeSubnets",
      "elasticmapreduce:ListInstances",
      "elasticmapreduce:DescribeCluster",
    ]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:aws:ec2:*:*:network-interface/*"]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values = [
        "aws:elasticmapreduce:editor-id",
        "aws:elasticmapreduce:job-flow-id",
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:HeadBucket",
      "s3:ListAllMyBuckets",
      "s3:GetAccountPublicAccessBlock",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:Create*",
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
    ]
    resources = local.emr_iam_policy_s3_resources
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:Abort*",
      "s3:Delete*",
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
    ]
    resources = formatlist("%s/*", local.emr_iam_policy_s3_resources)
  }
}

resource "aws_iam_policy" "emr_editors_role" {
  count  = module.this.enabled ? 1 : 0
  name   = "${local.emr_iam_policy_name_prefix}EmrNotebookAccess"
  policy = data.aws_iam_policy_document.emr_editors_role[0].json
}


# EmrNotebookServiceRole
data "aws_iam_policy_document" "emr_notebook_service_role" {
  count = module.this.enabled ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["elasticmapreduce.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "emr_notebook_service_role" {
  count              = module.this.enabled ? 1 : 0
  name               = "${local.emr_iam_policy_name_prefix}EmrNotebookServiceRole"
  assume_role_policy = data.aws_iam_policy_document.emr_notebook_service_role[0].json
}

resource "aws_iam_role_policy_attachment" "emr_notebook_service_role" {
  count      = module.this.enabled ? 1 : 0
  role       = aws_iam_role.emr_notebook_service_role[0].name
  policy_arn = aws_iam_policy.emr_editors_role[0].arn
}
