# terraform-aws-emr

Documentation to follow

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.8.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_emr_cluster"></a> [emr\_cluster](#module\_emr\_cluster) | ./modules/emr-cluster | n/a |
| <a name="module_emr_security_configuration"></a> [emr\_security\_configuration](#module\_emr\_security\_configuration) | ./modules/emr-security-configuration | n/a |
| <a name="module_label_cloudwatch_rule"></a> [label\_cloudwatch\_rule](#module\_label\_cloudwatch\_rule) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_cloudwatch_target"></a> [label\_cloudwatch\_target](#module\_label\_cloudwatch\_target) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_core"></a> [label\_core](#module\_label\_core) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_master"></a> [label\_master](#module\_label\_master) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_master_managed"></a> [label\_master\_managed](#module\_label\_master\_managed) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_notebook_instance"></a> [label\_notebook\_instance](#module\_label\_notebook\_instance) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_notebook_master"></a> [label\_notebook\_master](#module\_label\_notebook\_master) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_service_managed"></a> [label\_service\_managed](#module\_label\_service\_managed) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_slave"></a> [label\_slave](#module\_label\_slave) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_slave_managed"></a> [label\_slave\_managed](#module\_label\_slave\_managed) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.emr_bootstrap_script](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_security_group.managed_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.managed_service_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.managed_slave](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.notebook_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.notebook_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.slave](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.managed_master_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.managed_service_access_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.managed_service_access_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.managed_slave_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.master_egress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.master_egress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.master_ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.master_ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.notebook_instance_egress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.notebook_instance_egress_livy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.notebook_master_ingress_livy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.slave_egress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.slave_egress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.slave_ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.slave_ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | (Optional) A JSON string for selecting additional features such as adding proxy information. Note: Currently there is no API to retrieve the value of this argument after EMR cluster creation from provider, therefore Terraform cannot detect drift from the actual EMR cluster if its value is changed outside Terraform. | `string` | `null` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_applications"></a> [applications](#input\_applications) | (Optional) A list of applications for the cluster. | `set(string)` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_autoscaling_role"></a> [autoscaling\_role](#input\_autoscaling\_role) | (Optional) An IAM role for automatic scaling policies. The IAM role provides permissions that the automatic scaling feature requires to launch and terminate EC2 instances in an instance group | `string` | `null` | no |
| <a name="input_bootstrap_action"></a> [bootstrap\_action](#input\_bootstrap\_action) | (Optional) Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes. | <pre>list(object({<br>    name = string<br>    path = string<br>    args = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_bootstrap_s3_bucket"></a> [bootstrap\_s3\_bucket](#input\_bootstrap\_s3\_bucket) | (Required) The name of the bucket to put the file in. Alternatively, an S3 access point ARN can be specified. | `string` | `null` | no |
| <a name="input_bootstrap_s3_key"></a> [bootstrap\_s3\_key](#input\_bootstrap\_s3\_key) | (Required) The name of the object once it is in the bucket. | `string` | `null` | no |
| <a name="input_bootstrap_s3_kms_key_id"></a> [bootstrap\_s3\_kms\_key\_id](#input\_bootstrap\_s3\_kms\_key\_id) | (Optional) Specifies the AWS KMS Key ARN to use for object encryption. This value is a fully qualified ARN of the KMS Key. | `string` | `null` | no |
| <a name="input_bootstrap_s3_server_side_encryption"></a> [bootstrap\_s3\_server\_side\_encryption](#input\_bootstrap\_s3\_server\_side\_encryption) | (Optional) Specifies server-side encryption of the object in S3. Valid values are 'AES256' and 'aws:kms'. | `string` | `"AES256"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the job flow | `string` | `null` | no |
| <a name="input_configurations"></a> [configurations](#input\_configurations) | (Optional) List of configurations supplied for the EMR cluster you are creating | `string` | `null` | no |
| <a name="input_configurations_json"></a> [configurations\_json](#input\_configurations\_json) | (Optional) A JSON string for supplying list of configurations for the EMR cluster. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_core_instance_autoscaling_max_capacity"></a> [core\_instance\_autoscaling\_max\_capacity](#input\_core\_instance\_autoscaling\_max\_capacity) | (Required) The max capacity of the scalable target. | `number` | `1` | no |
| <a name="input_core_instance_autoscaling_min_capacity"></a> [core\_instance\_autoscaling\_min\_capacity](#input\_core\_instance\_autoscaling\_min\_capacity) | (Required) The min capacity of the scalable target. | `number` | `1` | no |
| <a name="input_core_instance_group_autoscaling_policy"></a> [core\_instance\_group\_autoscaling\_policy](#input\_core\_instance\_group\_autoscaling\_policy) | (Optional) String containing the EMR Auto Scaling Policy JSON. | `string` | `null` | no |
| <a name="input_core_instance_group_bid_price"></a> [core\_instance\_group\_bid\_price](#input\_core\_instance\_group\_bid\_price) | (Optional) Bid price for each EC2 instance in the instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances. | `string` | `null` | no |
| <a name="input_core_instance_group_ebs_config_iops"></a> [core\_instance\_group\_ebs\_config\_iops](#input\_core\_instance\_group\_ebs\_config\_iops) | (Optional) The number of I/O operations per second (IOPS) that the volume supports | `number` | `null` | no |
| <a name="input_core_instance_group_ebs_config_size"></a> [core\_instance\_group\_ebs\_config\_size](#input\_core\_instance\_group\_ebs\_config\_size) | (Required) The volume size, in gibibytes (GiB). | `number` | `null` | no |
| <a name="input_core_instance_group_ebs_config_type"></a> [core\_instance\_group\_ebs\_config\_type](#input\_core\_instance\_group\_ebs\_config\_type) | (Required) The volume type. Valid options are gp2, io1, standard and st1. | `string` | `null` | no |
| <a name="input_core_instance_group_ebs_config_volumes_per_instance"></a> [core\_instance\_group\_ebs\_config\_volumes\_per\_instance](#input\_core\_instance\_group\_ebs\_config\_volumes\_per\_instance) | (Optional) The number of EBS volumes with this configuration to attach to each EC2 instance in the instance group (default is 1) | `number` | `1` | no |
| <a name="input_core_instance_group_instance_count"></a> [core\_instance\_group\_instance\_count](#input\_core\_instance\_group\_instance\_count) | (Optional) Target number of instances for the instance group. Must be at least 1. Defaults to 1. | `number` | `1` | no |
| <a name="input_core_instance_group_instance_type"></a> [core\_instance\_group\_instance\_type](#input\_core\_instance\_group\_instance\_type) | (Required) EC2 instance type for all instances in the instance group. | `string` | `null` | no |
| <a name="input_custom_ami_id"></a> [custom\_ami\_id](#input\_custom\_ami\_id) | (Optional) A custom Amazon Linux AMI for the cluster (instead of an EMR-owned AMI). | `string` | `null` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_ebs_root_volume_size"></a> [ebs\_root\_volume\_size](#input\_ebs\_root\_volume\_size) | (Optional) Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later. | `number` | `null` | no |
| <a name="input_ec2_attributes_additional_master_security_groups"></a> [ec2\_attributes\_additional\_master\_security\_groups](#input\_ec2\_attributes\_additional\_master\_security\_groups) | (Optional) String containing a comma separated list of additional Amazon EC2 security group IDs for the master node | `string` | `null` | no |
| <a name="input_ec2_attributes_additional_slave_security_groups"></a> [ec2\_attributes\_additional\_slave\_security\_groups](#input\_ec2\_attributes\_additional\_slave\_security\_groups) | (Optional) String containing a comma separated list of additional Amazon EC2 security group IDs for the slave nodes as a comma separated string | `string` | `null` | no |
| <a name="input_ec2_attributes_emr_managed_master_security_group"></a> [ec2\_attributes\_emr\_managed\_master\_security\_group](#input\_ec2\_attributes\_emr\_managed\_master\_security\_group) | (Optional) Identifier of the Amazon EC2 EMR-Managed security group for the master node | `string` | `null` | no |
| <a name="input_ec2_attributes_emr_managed_slave_security_group"></a> [ec2\_attributes\_emr\_managed\_slave\_security\_group](#input\_ec2\_attributes\_emr\_managed\_slave\_security\_group) | (Optional) Identifier of the Amazon EC2 EMR-Managed security group for the slave nodes | `string` | `null` | no |
| <a name="input_ec2_attributes_instance_profile"></a> [ec2\_attributes\_instance\_profile](#input\_ec2\_attributes\_instance\_profile) | (Required) Instance Profile for EC2 instances of the cluster assume this role | `string` | `null` | no |
| <a name="input_ec2_attributes_key_name"></a> [ec2\_attributes\_key\_name](#input\_ec2\_attributes\_key\_name) | (Optional) Amazon EC2 key pair that can be used to ssh to the master node as the user called hadoop | `string` | `null` | no |
| <a name="input_ec2_attributes_service_access_security_group"></a> [ec2\_attributes\_service\_access\_security\_group](#input\_ec2\_attributes\_service\_access\_security\_group) | (Optional) Identifier of the Amazon EC2 service-access security group - required when the cluster runs on a private subnet | `string` | `null` | no |
| <a name="input_ec2_attributes_subnet_id"></a> [ec2\_attributes\_subnet\_id](#input\_ec2\_attributes\_subnet\_id) | (Optional) VPC subnet id where you want the job flow to launch. Cannot specify the cc1.4xlarge instance type for nodes of a job flow launched in a Amazon VPC | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_keep_job_flow_alive_when_no_steps"></a> [keep\_job\_flow\_alive\_when\_no\_steps](#input\_keep\_job\_flow\_alive\_when\_no\_steps) | (Optional) Switch on/off run cluster with no steps or when all steps are complete (default is on) | `bool` | `true` | no |
| <a name="input_kerberos_attributes_ad_domain_join_password"></a> [kerberos\_attributes\_ad\_domain\_join\_password](#input\_kerberos\_attributes\_ad\_domain\_join\_password) | (Optional) The Active Directory password for ad\_domain\_join\_user. Terraform cannot perform drift detection of this configuration | `string` | `null` | no |
| <a name="input_kerberos_attributes_ad_domain_join_user"></a> [kerberos\_attributes\_ad\_domain\_join\_user](#input\_kerberos\_attributes\_ad\_domain\_join\_user) | (Optional) Required only when establishing a cross-realm trust with an Active Directory domain. A user with sufficient privileges to join resources to the domain. Terraform cannot perform drift detection of this configuration. | `string` | `null` | no |
| <a name="input_kerberos_attributes_cross_realm_trust_principal_password"></a> [kerberos\_attributes\_cross\_realm\_trust\_principal\_password](#input\_kerberos\_attributes\_cross\_realm\_trust\_principal\_password) | (Optional) Required only when establishing a cross-realm trust with a KDC in a different realm. The cross-realm principal password, which must be identical across realms. Terraform cannot perform drift detection of this configuration. | `string` | `null` | no |
| <a name="input_kerberos_attributes_kdc_admin_password"></a> [kerberos\_attributes\_kdc\_admin\_password](#input\_kerberos\_attributes\_kdc\_admin\_password) | (Required) The password used within the cluster for the kadmin service on the cluster-dedicated KDC, which maintains Kerberos principals, password policies, and keytabs for the cluster. Terraform cannot perform drift detection of this configuration. | `string` | `null` | no |
| <a name="input_kerberos_attributes_realm"></a> [kerberos\_attributes\_realm](#input\_kerberos\_attributes\_realm) | (Required) The name of the Kerberos realm to which all nodes in a cluster belong. For example, EC2.INTERNAL | `string` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_log_uri"></a> [log\_uri](#input\_log\_uri) | (Optional) S3 bucket to write the log files of the job flow. If a value is not provided, logs are not created | `string` | `null` | no |
| <a name="input_master_allowed_cidr_blocks"></a> [master\_allowed\_cidr\_blocks](#input\_master\_allowed\_cidr\_blocks) | List of CIDR blocks to be allowed to access the master instances | `list(string)` | `[]` | no |
| <a name="input_master_allowed_security_groups"></a> [master\_allowed\_security\_groups](#input\_master\_allowed\_security\_groups) | List of security groups to be allowed to connect to the master instances | `list(string)` | `[]` | no |
| <a name="input_master_instance_group_bid_price"></a> [master\_instance\_group\_bid\_price](#input\_master\_instance\_group\_bid\_price) | (Optional) Bid price for each EC2 instance in the instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances | `string` | `null` | no |
| <a name="input_master_instance_group_ebs_config_iops"></a> [master\_instance\_group\_ebs\_config\_iops](#input\_master\_instance\_group\_ebs\_config\_iops) | (Optional) The number of I/O operations per second (IOPS) that the volume supports | `number` | `null` | no |
| <a name="input_master_instance_group_ebs_config_size"></a> [master\_instance\_group\_ebs\_config\_size](#input\_master\_instance\_group\_ebs\_config\_size) | (Required) The volume size, in gibibytes (GiB). | `number` | `null` | no |
| <a name="input_master_instance_group_ebs_config_type"></a> [master\_instance\_group\_ebs\_config\_type](#input\_master\_instance\_group\_ebs\_config\_type) | (Required) The volume type. Valid options are gp2, io1, standard and st1. | `string` | `null` | no |
| <a name="input_master_instance_group_ebs_config_volumes_per_instance"></a> [master\_instance\_group\_ebs\_config\_volumes\_per\_instance](#input\_master\_instance\_group\_ebs\_config\_volumes\_per\_instance) | (Optional) The number of EBS volumes with this configuration to attach to each EC2 instance in the instance group (default is 1) | `number` | `1` | no |
| <a name="input_master_instance_group_instance_count"></a> [master\_instance\_group\_instance\_count](#input\_master\_instance\_group\_instance\_count) | (Optional) Target number of instances for the instance group. Must be 1 or 3. Defaults to 1. Launching with multiple master nodes is only supported in EMR version 5.23.0+, and requires this resource's core\_instance\_group to be configured. Public (Internet accessible) instances must be created in VPC subnets that have map public IP on launch enabled. Termination protection is automatically enabled when launched with multiple master nodes and Terraform must have the termination\_protection = false configuration applied before destroying this resource. | `number` | `null` | no |
| <a name="input_master_instance_group_instance_type"></a> [master\_instance\_group\_instance\_type](#input\_master\_instance\_group\_instance\_type) | (Required) EC2 instance type for all instances in the instance group. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_release_label"></a> [release\_label](#input\_release\_label) | (Required) The release label for the Amazon EMR release | `string` | n/a | yes |
| <a name="input_scale_down_behavior"></a> [scale\_down\_behavior](#input\_scale\_down\_behavior) | (Optional) The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized. | `string` | `null` | no |
| <a name="input_security_configuration"></a> [security\_configuration](#input\_security\_configuration) | (Optional) The security configuration name to attach to the EMR cluster. Only valid for EMR clusters with release\_label 4.8.0 or greater | `string` | `null` | no |
| <a name="input_service_role"></a> [service\_role](#input\_service\_role) | (Required) IAM role that will be assumed by the Amazon EMR service to access AWS resources | `string` | `null` | no |
| <a name="input_slave_allowed_cidr_blocks"></a> [slave\_allowed\_cidr\_blocks](#input\_slave\_allowed\_cidr\_blocks) | List of CIDR blocks to be allowed to access the slave instances | `list(string)` | `[]` | no |
| <a name="input_slave_allowed_security_groups"></a> [slave\_allowed\_security\_groups](#input\_slave\_allowed\_security\_groups) | List of security groups to be allowed to connect to the slave instances | `list(string)` | `[]` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | (Required) The Amazon Resource Name (ARN) associated of the SNS target. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_step"></a> [step](#input\_step) | (Optional) List of steps to run when creating the cluster. | `list(any)` | `[]` | no |
| <a name="input_step_concurrency_level"></a> [step\_concurrency\_level](#input\_step\_concurrency\_level) | (Optional) The number of steps that can be executed concurrently. You can specify a maximum of 256 steps. | `number` | `1` | no |
| <a name="input_subnet_type"></a> [subnet\_type](#input\_subnet\_type) | The type of subnet the EMR cluster is provisioned in. Used to determine if service related security groups are required. Defaults to 'private' | `string` | `"private"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_termination_protection"></a> [termination\_protection](#input\_termination\_protection) | (Optional) Switch on/off termination protection (default is false, except when using multiple master nodes). Before attempting to destroy the resource when termination protection is enabled, this configuration must be applied with its value set to false. | `bool` | `false` | no |
| <a name="input_visible_to_all_users"></a> [visible\_to\_all\_users](#input\_visible\_to\_all\_users) | (Optional) Whether the job flow is visible to all IAM users of the AWS account associated with the job flow. | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to create the security groups in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_applications"></a> [applications](#output\_applications) | The applications installed on this cluster. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the cluster. |
| <a name="output_bootstrap_action"></a> [bootstrap\_action](#output\_bootstrap\_action) | A list of bootstrap actions that will be run before Hadoop is started on the cluster nodes. |
| <a name="output_configurations"></a> [configurations](#output\_configurations) | The list of Configurations supplied to the EMR cluster. |
| <a name="output_core_instance_group_0_id"></a> [core\_instance\_group\_0\_id](#output\_core\_instance\_group\_0\_id) | Core node type Instance Group ID, if using Instance Group for this node type. |
| <a name="output_ec2_attributes"></a> [ec2\_attributes](#output\_ec2\_attributes) | Provides information about the EC2 instances in a cluster grouped by category: key name, subnet ID, IAM instance profile, and so on. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the EMR Cluster |
| <a name="output_log_uri"></a> [log\_uri](#output\_log\_uri) | The path to the Amazon S3 location where logs for this cluster are stored. |
| <a name="output_managed_master_security_group_id"></a> [managed\_master\_security\_group\_id](#output\_managed\_master\_security\_group\_id) | EMR managed\_master security group ID |
| <a name="output_managed_service_access_security_group_id"></a> [managed\_service\_access\_security\_group\_id](#output\_managed\_service\_access\_security\_group\_id) | EMR managed\_service\_access security group ID |
| <a name="output_managed_slave_security_group_id"></a> [managed\_slave\_security\_group\_id](#output\_managed\_slave\_security\_group\_id) | EMR managed\_slave security group ID |
| <a name="output_master_instance_group_0_id"></a> [master\_instance\_group\_0\_id](#output\_master\_instance\_group\_0\_id) | Master node type Instance Group ID, if using Instance Group for this node type. |
| <a name="output_master_public_dns"></a> [master\_public\_dns](#output\_master\_public\_dns) | The public DNS name of the master EC2 instance. |
| <a name="output_master_security_group_id"></a> [master\_security\_group\_id](#output\_master\_security\_group\_id) | EMR master security group ID |
| <a name="output_name"></a> [name](#output\_name) | The name of the cluster. |
| <a name="output_notebook_instance_security_group_id"></a> [notebook\_instance\_security\_group\_id](#output\_notebook\_instance\_security\_group\_id) | Notebook instance security group ID |
| <a name="output_notebook_master_security_group_id"></a> [notebook\_master\_security\_group\_id](#output\_notebook\_master\_security\_group\_id) | Notebook master security group ID |
| <a name="output_release_label"></a> [release\_label](#output\_release\_label) | The release label for the Amazon EMR release. |
| <a name="output_service_role"></a> [service\_role](#output\_service\_role) | The IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf. |
| <a name="output_slave_security_group_id"></a> [slave\_security\_group\_id](#output\_slave\_security\_group\_id) | EMR slave security group ID |
| <a name="output_visible_to_all_users"></a> [visible\_to\_all\_users](#output\_visible\_to\_all\_users) | Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow. |
<!-- END_TF_DOCS -->
