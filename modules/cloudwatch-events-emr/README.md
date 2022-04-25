# cloudwatch-events-emr

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_event_rule"></a> [event\_rule](#module\_event\_rule) | cloudposse/label/null | 0.25.0 |
| <a name="module_event_target"></a> [event\_target](#module\_event\_target) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_emr_cluster_id"></a> [emr\_cluster\_id](#input\_emr\_cluster\_id) | Id the target EMR cluster to use as event source | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_event_rule_description"></a> [event\_rule\_description](#input\_event\_rule\_description) | (Optional) The description of the rule. | `string` | `null` | no |
| <a name="input_event_rule_event_pattern"></a> [event\_rule\_event\_pattern](#input\_event\_rule\_event\_pattern) | (Required, if schedule\_expression isn't specified) Event pattern described a JSON object. | `string` | `null` | no |
| <a name="input_event_rule_is_enabled"></a> [event\_rule\_is\_enabled](#input\_event\_rule\_is\_enabled) | (Optional) Whether the rule should be enabled (defaults to true). | `bool` | `true` | no |
| <a name="input_event_rule_name"></a> [event\_rule\_name](#input\_event\_rule\_name) | (Optional) The rule's name. By default generated by Terraform. | `string` | `null` | no |
| <a name="input_event_rule_name_prefix"></a> [event\_rule\_name\_prefix](#input\_event\_rule\_name\_prefix) | (Optional) The rule's name. Conflicts with name. | `string` | `null` | no |
| <a name="input_event_rule_role_arn"></a> [event\_rule\_role\_arn](#input\_event\_rule\_role\_arn) | (Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation. | `string` | `null` | no |
| <a name="input_event_rule_schedule_expression"></a> [event\_rule\_schedule\_expression](#input\_event\_rule\_schedule\_expression) | (Required, if event\_pattern isn't specified) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). | `string` | `null` | no |
| <a name="input_event_target_arn"></a> [event\_target\_arn](#input\_event\_target\_arn) | (Required) The Amazon Resource Name (ARN) associated of the target. | `string` | n/a | yes |
| <a name="input_event_target_batch_target"></a> [event\_target\_batch\_target](#input\_event\_target\_batch\_target) | (Optional) Parameters used when you are using the rule to invoke an Amazon Batch Job. Documented below. A maximum of 1 are allowed. | `list(any)` | `[]` | no |
| <a name="input_event_target_ecs_target"></a> [event\_target\_ecs\_target](#input\_event\_target\_ecs\_target) | (Optional) Parameters used when you are using the rule to invoke Amazon ECS Task. Documented below. A maximum of 1 are allowed. | `list(any)` | `[]` | no |
| <a name="input_event_target_input"></a> [event\_target\_input](#input\_event\_target\_input) | (Optional) Valid JSON text passed to the target. | `string` | `null` | no |
| <a name="input_event_target_input_path"></a> [event\_target\_input\_path](#input\_event\_target\_input\_path) | (Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target. | `string` | `null` | no |
| <a name="input_event_target_input_transformer"></a> [event\_target\_input\_transformer](#input\_event\_target\_input\_transformer) | (Optional) Parameters used when you are providing a custom input to a target based on certain event data. | `list(any)` | `[]` | no |
| <a name="input_event_target_kinesis_target"></a> [event\_target\_kinesis\_target](#input\_event\_target\_kinesis\_target) | (Optional) Parameters used when you are using the rule to invoke an Amazon Kinesis Stream. Documented below. A maximum of 1 are allowed. | `list(any)` | `[]` | no |
| <a name="input_event_target_role_arn"></a> [event\_target\_role\_arn](#input\_event\_target\_role\_arn) | (Optional) The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. Required if ecs\_target is used. | `string` | `null` | no |
| <a name="input_event_target_rule"></a> [event\_target\_rule](#input\_event\_target\_rule) | (Required) The name of the rule you want to add targets to. | `string` | n/a | yes |
| <a name="input_event_target_run_command_targets"></a> [event\_target\_run\_command\_targets](#input\_event\_target\_run\_command\_targets) | (Optional) Parameters used when you are using the rule to invoke Amazon EC2 Run Command. Documented below. A maximum of 5 are allowed. | `list(any)` | `[]` | no |
| <a name="input_event_target_sqs_target"></a> [event\_target\_sqs\_target](#input\_event\_target\_sqs\_target) | (Optional) Parameters used when you are using the rule to invoke an Amazon SQS Queue. Documented below. A maximum of 1 are allowed. | `list(any)` | `[]` | no |
| <a name="input_event_target_target_id"></a> [event\_target\_target\_id](#input\_event\_target\_target\_id) | (Optional) The unique target assignment ID. If missing, will generate a random, unique id. | `string` | `null` | no |
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
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the rule. |
| <a name="output_id"></a> [id](#output\_id) | The name of the rule. |
| <a name="output_name"></a> [name](#output\_name) | The rule's name. |
<!-- END_TF_DOCS -->
