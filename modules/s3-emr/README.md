# s3-emr

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
| <a name="module_s3_bucket_emr_admin"></a> [s3\_bucket\_emr\_admin](#module\_s3\_bucket\_emr\_admin) | cloudposse/s3-bucket/aws | 2.0.0 |
| <a name="module_s3_bucket_emr_checkpoints"></a> [s3\_bucket\_emr\_checkpoints](#module\_s3\_bucket\_emr\_checkpoints) | cloudposse/s3-bucket/aws | 2.0.0 |
| <a name="module_s3_bucket_emr_data"></a> [s3\_bucket\_emr\_data](#module\_s3\_bucket\_emr\_data) | cloudposse/s3-bucket/aws | 2.0.0 |
| <a name="module_s3_bucket_emr_logs"></a> [s3\_bucket\_emr\_logs](#module\_s3\_bucket\_emr\_logs) | cloudposse/s3-log-storage/aws | 0.28.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |
| <a name="module_utils"></a> [utils](#module\_utils) | cloudposse/utils/aws | 0.8.1 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_mini_attrs"></a> [mini\_attrs](#input\_mini\_attrs) | (Optional) Enable/Disable use of minified aws attributes (accounts, regions, etc) | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_s3_emr_admin_allow_encrypted_uploads_only"></a> [s3\_emr\_admin\_allow\_encrypted\_uploads\_only](#input\_s3\_emr\_admin\_allow\_encrypted\_uploads\_only) | Set to true to prevent uploads of unencrypted objects to S3 bucket | `bool` | `false` | no |
| <a name="input_s3_emr_admin_force_destroy"></a> [s3\_emr\_admin\_force\_destroy](#input\_s3\_emr\_admin\_force\_destroy) | (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| <a name="input_s3_emr_admin_sse_algorithm"></a> [s3\_emr\_admin\_sse\_algorithm](#input\_s3\_emr\_admin\_sse\_algorithm) | (required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| <a name="input_s3_emr_checkpoints_allow_encrypted_uploads_only"></a> [s3\_emr\_checkpoints\_allow\_encrypted\_uploads\_only](#input\_s3\_emr\_checkpoints\_allow\_encrypted\_uploads\_only) | Set to true to prevent uploads of unencrypted objects to S3 bucket | `bool` | `false` | no |
| <a name="input_s3_emr_checkpoints_force_destroy"></a> [s3\_emr\_checkpoints\_force\_destroy](#input\_s3\_emr\_checkpoints\_force\_destroy) | (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| <a name="input_s3_emr_checkpoints_sse_algorithm"></a> [s3\_emr\_checkpoints\_sse\_algorithm](#input\_s3\_emr\_checkpoints\_sse\_algorithm) | (required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| <a name="input_s3_emr_data_allow_encrypted_uploads_only"></a> [s3\_emr\_data\_allow\_encrypted\_uploads\_only](#input\_s3\_emr\_data\_allow\_encrypted\_uploads\_only) | Set to true to prevent uploads of unencrypted objects to S3 bucket | `bool` | `false` | no |
| <a name="input_s3_emr_data_force_destroy"></a> [s3\_emr\_data\_force\_destroy](#input\_s3\_emr\_data\_force\_destroy) | (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| <a name="input_s3_emr_data_sse_algorithm"></a> [s3\_emr\_data\_sse\_algorithm](#input\_s3\_emr\_data\_sse\_algorithm) | (required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| <a name="input_s3_emr_logs_force_destroy"></a> [s3\_emr\_logs\_force\_destroy](#input\_s3\_emr\_logs\_force\_destroy) | (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| <a name="input_s3_emr_logs_sse_algorithm"></a> [s3\_emr\_logs\_sse\_algorithm](#input\_s3\_emr\_logs\_sse\_algorithm) | (required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| <a name="input_s3_replica_region"></a> [s3\_replica\_region](#input\_s3\_replica\_region) | (optional) AWS Region to replicate s3 buckets to | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_emr_admin_arn"></a> [s3\_bucket\_emr\_admin\_arn](#output\_s3\_bucket\_emr\_admin\_arn) | The ARN of the 's3\_bucket\_emr\_admin' bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_bucket_emr_admin_id"></a> [s3\_bucket\_emr\_admin\_id](#output\_s3\_bucket\_emr\_admin\_id) | The name of the 's3\_bucket\_emr\_admin' bucket. |
| <a name="output_s3_bucket_emr_checkpoints_arn"></a> [s3\_bucket\_emr\_checkpoints\_arn](#output\_s3\_bucket\_emr\_checkpoints\_arn) | The ARN of the 's3\_bucket\_emr\_checkpoints' bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_bucket_emr_checkpoints_id"></a> [s3\_bucket\_emr\_checkpoints\_id](#output\_s3\_bucket\_emr\_checkpoints\_id) | The name of the 's3\_bucket\_emr\_checkpoints' bucket. |
| <a name="output_s3_bucket_emr_data_arn"></a> [s3\_bucket\_emr\_data\_arn](#output\_s3\_bucket\_emr\_data\_arn) | The ARN of the 's3\_bucket\_emr\_data' bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_bucket_emr_data_id"></a> [s3\_bucket\_emr\_data\_id](#output\_s3\_bucket\_emr\_data\_id) | The name of the 's3\_bucket\_emr\_data' bucket. |
| <a name="output_s3_bucket_emr_logs_arn"></a> [s3\_bucket\_emr\_logs\_arn](#output\_s3\_bucket\_emr\_logs\_arn) | The ARN of the 's3\_bucket\_emr\_logs' bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_bucket_emr_logs_id"></a> [s3\_bucket\_emr\_logs\_id](#output\_s3\_bucket\_emr\_logs\_id) | The name of the 's3\_bucket\_emr\_logs' bucket. |
<!-- END_TF_DOCS -->