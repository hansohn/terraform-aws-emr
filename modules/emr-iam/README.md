# emr-iam

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.44.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_group_policy_attachment.emr_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_instance_profile.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.emr_editors_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.emr_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ec2_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.emr_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.emr_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.emr_notebook_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.emr_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.emr_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.emr_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.emr_notebook_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ec2_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.emr_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.emr_editors_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.emr_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.emr_notebook_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_emr_iam_full_access_group_name"></a> [emr\_iam\_full\_access\_group\_name](#input\_emr\_iam\_full\_access\_group\_name) | IAM group name to attach EMR IAM full access policy to | `string` | `""` | no |
| <a name="input_emr_iam_full_access_role_name"></a> [emr\_iam\_full\_access\_role\_name](#input\_emr\_iam\_full\_access\_role\_name) | IAM role name to attach EMR IAM full access policy to | `string` | `""` | no |
| <a name="input_emr_iam_policy_name_app"></a> [emr\_iam\_policy\_name\_app](#input\_emr\_iam\_policy\_name\_app) | App name to include when auto generating policy\_name\_prefix. Defaults to 'EMR' | `string` | `"EMR"` | no |
| <a name="input_emr_iam_policy_name_prefix"></a> [emr\_iam\_policy\_name\_prefix](#input\_emr\_iam\_policy\_name\_prefix) | Prefix to use when naming EMR IAM read/full access policies | `string` | `""` | no |
| <a name="input_emr_iam_policy_resources"></a> [emr\_iam\_policy\_resources](#input\_emr\_iam\_policy\_resources) | List of resources to include in EMR IAM read/full access policies | `list(string)` | `[]` | no |
| <a name="input_emr_iam_policy_s3_resources"></a> [emr\_iam\_policy\_s3\_resources](#input\_emr\_iam\_policy\_s3\_resources) | List of S3 resources to include in EMR IAM read/full access policies | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_ec2_assume_role_arn"></a> [iam\_ec2\_assume\_role\_arn](#output\_iam\_ec2\_assume\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_iam_ec2_assume_role_id"></a> [iam\_ec2\_assume\_role\_id](#output\_iam\_ec2\_assume\_role\_id) | The id of the role |
| <a name="output_iam_ec2_assume_role_name"></a> [iam\_ec2\_assume\_role\_name](#output\_iam\_ec2\_assume\_role\_name) | The name of the role |
| <a name="output_iam_ec2_assume_role_unique_id"></a> [iam\_ec2\_assume\_role\_unique\_id](#output\_iam\_ec2\_assume\_role\_unique\_id) | The stable and unique string identifying the role |
| <a name="output_iam_ec2_autoscaling_role_arn"></a> [iam\_ec2\_autoscaling\_role\_arn](#output\_iam\_ec2\_autoscaling\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_iam_ec2_autoscaling_role_id"></a> [iam\_ec2\_autoscaling\_role\_id](#output\_iam\_ec2\_autoscaling\_role\_id) | The id of the role |
| <a name="output_iam_ec2_autoscaling_role_name"></a> [iam\_ec2\_autoscaling\_role\_name](#output\_iam\_ec2\_autoscaling\_role\_name) | The name of the role |
| <a name="output_iam_ec2_autoscaling_role_unique_id"></a> [iam\_ec2\_autoscaling\_role\_unique\_id](#output\_iam\_ec2\_autoscaling\_role\_unique\_id) | The stable and unique string identifying the role |
| <a name="output_iam_ec2_instance_profile_arn"></a> [iam\_ec2\_instance\_profile\_arn](#output\_iam\_ec2\_instance\_profile\_arn) | The ARN assigned by AWS to the instance profile. |
| <a name="output_iam_ec2_instance_profile_id"></a> [iam\_ec2\_instance\_profile\_id](#output\_iam\_ec2\_instance\_profile\_id) | The instance profile's ID. |
| <a name="output_iam_ec2_instance_profile_name"></a> [iam\_ec2\_instance\_profile\_name](#output\_iam\_ec2\_instance\_profile\_name) | The instance profile's name. |
| <a name="output_iam_emr_assume_role_arn"></a> [iam\_emr\_assume\_role\_arn](#output\_iam\_emr\_assume\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_iam_emr_assume_role_id"></a> [iam\_emr\_assume\_role\_id](#output\_iam\_emr\_assume\_role\_id) | The id of the role |
| <a name="output_iam_emr_assume_role_name"></a> [iam\_emr\_assume\_role\_name](#output\_iam\_emr\_assume\_role\_name) | The name of the role |
| <a name="output_iam_emr_assume_role_unique_id"></a> [iam\_emr\_assume\_role\_unique\_id](#output\_iam\_emr\_assume\_role\_unique\_id) | The stable and unique string identifying the role |
| <a name="output_iam_emr_autoscaling_role_arn"></a> [iam\_emr\_autoscaling\_role\_arn](#output\_iam\_emr\_autoscaling\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_iam_emr_autoscaling_role_id"></a> [iam\_emr\_autoscaling\_role\_id](#output\_iam\_emr\_autoscaling\_role\_id) | The id of the role |
| <a name="output_iam_emr_autoscaling_role_name"></a> [iam\_emr\_autoscaling\_role\_name](#output\_iam\_emr\_autoscaling\_role\_name) | The name of the role |
| <a name="output_iam_emr_autoscaling_role_unique_id"></a> [iam\_emr\_autoscaling\_role\_unique\_id](#output\_iam\_emr\_autoscaling\_role\_unique\_id) | The stable and unique string identifying the role |
| <a name="output_iam_emr_full_access_arn"></a> [iam\_emr\_full\_access\_arn](#output\_iam\_emr\_full\_access\_arn) | The ARN assigned by AWS to this EMR Put policy. |
| <a name="output_iam_emr_full_access_id"></a> [iam\_emr\_full\_access\_id](#output\_iam\_emr\_full\_access\_id) | The EMR Put policy ID |
<!-- END_TF_DOCS -->
