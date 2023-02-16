# emr-cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_emr_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | (Optional) A JSON string for selecting additional features such as adding proxy information. Note: Currently there is no API to retrieve the value of this argument after EMR cluster creation from provider, therefore Terraform cannot detect drift from the actual EMR cluster if its value is changed outside Terraform. | `string` | `null` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_applications"></a> [applications](#input\_applications) | (Optional) A list of applications for the cluster. | `set(string)` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auto_termination_policy"></a> [auto\_termination\_policy](#input\_auto\_termination\_policy) | (Optional) An auto-termination policy for an Amazon EMR cluster. An auto-termination policy defines the amount of idle time in seconds after which a cluster automatically terminates. | `list(any)` | `[]` | no |
| <a name="input_autoscaling_role"></a> [autoscaling\_role](#input\_autoscaling\_role) | (Optional) An IAM role for automatic scaling policies. The IAM role provides permissions that the automatic scaling feature requires to launch and terminate EC2 instances in an instance group | `string` | `null` | no |
| <a name="input_bootstrap_action"></a> [bootstrap\_action](#input\_bootstrap\_action) | (Optional) Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes. | <pre>list(object({<br>    name = string<br>    path = string<br>    args = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | (Required) The name of the job flow | `string` | `null` | no |
| <a name="input_configurations"></a> [configurations](#input\_configurations) | (Optional) List of configurations supplied for the EMR cluster you are creating | `string` | `null` | no |
| <a name="input_configurations_json"></a> [configurations\_json](#input\_configurations\_json) | (Optional) A JSON string for supplying list of configurations for the EMR cluster. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_core_instance_fleet"></a> [core\_instance\_fleet](#input\_core\_instance\_fleet) | (Optional) Configuration block to use an Instance Fleet for the core node type. Cannot be specified if any core\_instance\_group configuration blocks are set. | `list(any)` | `[]` | no |
| <a name="input_core_instance_group"></a> [core\_instance\_group](#input\_core\_instance\_group) | (Optional) Configuration block to use an Instance Group for the core node type. | `list(any)` | `[]` | no |
| <a name="input_custom_ami_id"></a> [custom\_ami\_id](#input\_custom\_ami\_id) | (Optional) A custom Amazon Linux AMI for the cluster (instead of an EMR-owned AMI). | `string` | `null` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_ebs_root_volume_size"></a> [ebs\_root\_volume\_size](#input\_ebs\_root\_volume\_size) | (Optional) Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later. | `number` | `null` | no |
| <a name="input_ec2_attributes"></a> [ec2\_attributes](#input\_ec2\_attributes) | (Optional) Attributes for the EC2 instances running the job flow. | `list(any)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_keep_job_flow_alive_when_no_steps"></a> [keep\_job\_flow\_alive\_when\_no\_steps](#input\_keep\_job\_flow\_alive\_when\_no\_steps) | (Optional) Switch on/off run cluster with no steps or when all steps are complete (default is on) | `bool` | `true` | no |
| <a name="input_kerberos_attributes"></a> [kerberos\_attributes](#input\_kerberos\_attributes) | (Optional) Kerberos configuration for the cluster. | `list(any)` | `[]` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_log_encryption_kms_key_id"></a> [log\_encryption\_kms\_key\_id](#input\_log\_encryption\_kms\_key\_id) | (Optional) AWS KMS customer master key (CMK) key ID or arn used for encrypting log files. This attribute is only available with EMR version 5.30.0 and later, excluding EMR 6.0.0. | `string` | `null` | no |
| <a name="input_log_uri"></a> [log\_uri](#input\_log\_uri) | (Optional) S3 bucket to write the log files of the job flow. If a value is not provided, logs are not created | `string` | `null` | no |
| <a name="input_master_instance_fleet"></a> [master\_instance\_fleet](#input\_master\_instance\_fleet) | (Optional) Configuration block to use an Instance Fleet for the master node type. Cannot be specified if any master\_instance\_group configuration blocks are set. | `list(any)` | `[]` | no |
| <a name="input_master_instance_group"></a> [master\_instance\_group](#input\_master\_instance\_group) | (Optional) Configuration block to use an Instance Group for the master node type. | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_release_label"></a> [release\_label](#input\_release\_label) | (Required) The release label for the Amazon EMR release | `string` | n/a | yes |
| <a name="input_scale_down_behavior"></a> [scale\_down\_behavior](#input\_scale\_down\_behavior) | (Optional) The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized. | `string` | `null` | no |
| <a name="input_security_configuration"></a> [security\_configuration](#input\_security\_configuration) | (Optional) The security configuration name to attach to the EMR cluster. Only valid for EMR clusters with release\_label 4.8.0 or greater | `string` | `null` | no |
| <a name="input_service_role"></a> [service\_role](#input\_service\_role) | (Required) IAM role that will be assumed by the Amazon EMR service to access AWS resources | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_step"></a> [step](#input\_step) | (Optional) List of steps to run when creating the cluster. | `list(any)` | `[]` | no |
| <a name="input_step_concurrency_level"></a> [step\_concurrency\_level](#input\_step\_concurrency\_level) | (Optional) The number of steps that can be executed concurrently. You can specify a maximum of 256 steps. | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_termination_protection"></a> [termination\_protection](#input\_termination\_protection) | (Optional) Switch on/off termination protection (default is false, except when using multiple master nodes). Before attempting to destroy the resource when termination protection is enabled, this configuration must be applied with its value set to false. | `bool` | `false` | no |
| <a name="input_visible_to_all_users"></a> [visible\_to\_all\_users](#input\_visible\_to\_all\_users) | (Optional) Whether the job flow is visible to all IAM users of the AWS account associated with the job flow. | `bool` | `true` | no |

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
| <a name="output_master_instance_group_0_id"></a> [master\_instance\_group\_0\_id](#output\_master\_instance\_group\_0\_id) | Master node type Instance Group ID, if using Instance Group for this node type. |
| <a name="output_master_public_dns"></a> [master\_public\_dns](#output\_master\_public\_dns) | The public DNS name of the master EC2 instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the cluster. |
| <a name="output_release_label"></a> [release\_label](#output\_release\_label) | The release label for the Amazon EMR release. |
| <a name="output_service_role"></a> [service\_role](#output\_service\_role) | The IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_visible_to_all_users"></a> [visible\_to\_all\_users](#output\_visible\_to\_all\_users) | Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow. |
<!-- END_TF_DOCS -->
