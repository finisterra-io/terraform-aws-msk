
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_msk_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster) | resource |
| [aws_msk_configuration.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_configuration) | resource |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appautoscaling_policy_name"></a> [appautoscaling\_policy\_name](#input\_appautoscaling\_policy\_name) | The name of the policy to use for the cluster | `string` | `null` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | To automatically expand your cluster's storage in response to increased usage, you can enable this. [More info](https://docs.aws.amazon.com/msk/latest/developerguide/msk-autoexpand.html) | `bool` | `true` | no |
| <a name="input_broker_instance_type"></a> [broker\_instance\_type](#input\_broker\_instance\_type) | The instance type to use for the Kafka brokers | `string` | n/a | yes |
| <a name="input_broker_per_zone"></a> [broker\_per\_zone](#input\_broker\_per\_zone) | Number of Kafka brokers per zone | `number` | `1` | no |
| <a name="input_broker_volume_size"></a> [broker\_volume\_size](#input\_broker\_volume\_size) | The size in GiB of the EBS volume for the data drive on each broker node | `number` | `1000` | no |
| <a name="input_client_authentication"></a> [client\_authentication](#input\_client\_authentication) | The client authentication of the cluster | `list(any)` | `[]` | no |
| <a name="input_client_broker"></a> [client\_broker](#input\_client\_broker) | Encryption setting for data in transit between clients and brokers. Valid values: `TLS`, `TLS_PLAINTEXT`, and `PLAINTEXT` | `string` | `"TLS"` | no |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs | `bool` | `false` | no |
| <a name="input_cloudwatch_logs_log_group"></a> [cloudwatch\_logs\_log\_group](#input\_cloudwatch\_logs\_log\_group) | Name of the Cloudwatch Log Group to deliver logs to | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the MSK cluster | `string` | n/a | yes |
| <a name="input_config_kafka_versions"></a> [config\_kafka\_versions](#input\_config\_kafka\_versions) | The config kafka versions of the cluster | `list(any)` | `[]` | no |
| <a name="input_configuration_description"></a> [configuration\_description](#input\_configuration\_description) | The description of the configuration to use for the cluster | `string` | `null` | no |
| <a name="input_configuration_name"></a> [configuration\_name](#input\_configuration\_name) | The name of the configuration to use for the cluster | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to `true` to enable the MSK cluster | `bool` | `true` | no |
| <a name="input_encryption_at_rest_kms_key_arn"></a> [encryption\_at\_rest\_kms\_key\_arn](#input\_encryption\_at\_rest\_kms\_key\_arn) | You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest | `string` | `""` | no |
| <a name="input_encryption_in_cluster"></a> [encryption\_in\_cluster](#input\_encryption\_in\_cluster) | Whether data communication among broker nodes is encrypted | `bool` | `true` | no |
| <a name="input_enhanced_monitoring"></a> [enhanced\_monitoring](#input\_enhanced\_monitoring) | Specify the desired enhanced MSK CloudWatch monitoring level. Valid values: `DEFAULT`, `PER_BROKER`, and `PER_TOPIC_PER_BROKER` | `string` | `"DEFAULT"` | no |
| <a name="input_firehose_delivery_stream"></a> [firehose\_delivery\_stream](#input\_firehose\_delivery\_stream) | Name of the Kinesis Data Firehose delivery stream to deliver logs to | `string` | `""` | no |
| <a name="input_firehose_logs_enabled"></a> [firehose\_logs\_enabled](#input\_firehose\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose | `bool` | `false` | no |
| <a name="input_jmx_exporter_enabled"></a> [jmx\_exporter\_enabled](#input\_jmx\_exporter\_enabled) | Set `true` to enable the JMX Exporter | `bool` | `false` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | The desired Kafka software version.<br>Refer to https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html for more details | `string` | n/a | yes |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | The maximum capacity of the cluster | `number` | `null` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | The minimum capacity of the cluster | `number` | `null` | no |
| <a name="input_node_exporter_enabled"></a> [node\_exporter\_enabled](#input\_node\_exporter\_enabled) | Set `true` to enable the Node Exporter | `bool` | `false` | no |
| <a name="input_number_of_broker_nodes"></a> [number\_of\_broker\_nodes](#input\_number\_of\_broker\_nodes) | The number of broker nodes in the cluster | `number` | n/a | yes |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | The policy type of the cluster | `string` | `null` | no |
| <a name="input_predefined_metric_type"></a> [predefined\_metric\_type](#input\_predefined\_metric\_type) | The predefined metric type of the cluster | `string` | `null` | no |
| <a name="input_provisioned_throughput"></a> [provisioned\_throughput](#input\_provisioned\_throughput) | The provisioned throughput of the cluster | `list(any)` | `[]` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Enable public access to MSK cluster (given that all of the requirements are met) | `bool` | `false` | no |
| <a name="input_s3_logs_bucket"></a> [s3\_logs\_bucket](#input\_s3\_logs\_bucket) | Name of the S3 bucket to deliver logs to | `string` | `""` | no |
| <a name="input_s3_logs_enabled"></a> [s3\_logs\_enabled](#input\_s3\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to S3 | `bool` | `false` | no |
| <a name="input_s3_logs_prefix"></a> [s3\_logs\_prefix](#input\_s3\_logs\_prefix) | Prefix to append to the S3 folder name logs are delivered to | `string` | `""` | no |
| <a name="input_scalable_dimension"></a> [scalable\_dimension](#input\_scalable\_dimension) | The scalable dimension of the cluster | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups of the cluster | `list(any)` | `[]` | no |
| <a name="input_server_properties"></a> [server\_properties](#input\_server\_properties) | Contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html) | `map(string)` | `{}` | no |
| <a name="input_service_namespace"></a> [service\_namespace](#input\_service\_namespace) | The service namespace of the cluster | `string` | `null` | no |
| <a name="input_storage_autoscaling_disable_scale_in"></a> [storage\_autoscaling\_disable\_scale\_in](#input\_storage\_autoscaling\_disable\_scale\_in) | If the value is true, scale in is disabled and the target tracking policy won't remove capacity from the scalable resource | `bool` | `false` | no |
| <a name="input_storage_autoscaling_target_value"></a> [storage\_autoscaling\_target\_value](#input\_storage\_autoscaling\_target\_value) | Percentage of storage used to trigger autoscaled storage increase | `number` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs for Client Broker | `list(string)` | `null` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | Subnet names for Client Broker | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | `null` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | Comma separated list of one or more hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka cluster |
| <a name="output_bootstrap_brokers_public_sasl_iam"></a> [bootstrap\_brokers\_public\_sasl\_iam](#output\_bootstrap\_brokers\_public\_sasl\_iam) | Comma separated list of one or more DNS names (or IP addresses) and SASL IAM port pairs for public access to the Kafka cluster using SASL/IAM |
| <a name="output_bootstrap_brokers_public_sasl_scram"></a> [bootstrap\_brokers\_public\_sasl\_scram](#output\_bootstrap\_brokers\_public\_sasl\_scram) | Comma separated list of one or more DNS names (or IP addresses) and SASL SCRAM port pairs for public access to the Kafka cluster using SASL/SCRAM |
| <a name="output_bootstrap_brokers_public_tls"></a> [bootstrap\_brokers\_public\_tls](#output\_bootstrap\_brokers\_public\_tls) | Comma separated list of one or more DNS names (or IP addresses) and TLS port pairs for public access to the Kafka cluster using TLS |
| <a name="output_bootstrap_brokers_sasl_iam"></a> [bootstrap\_brokers\_sasl\_iam](#output\_bootstrap\_brokers\_sasl\_iam) | Comma separated list of one or more DNS names (or IP addresses) and SASL IAM port pairs for access to the Kafka cluster using SASL/IAM |
| <a name="output_bootstrap_brokers_sasl_scram"></a> [bootstrap\_brokers\_sasl\_scram](#output\_bootstrap\_brokers\_sasl\_scram) | Comma separated list of one or more DNS names (or IP addresses) and SASL SCRAM port pairs for access to the Kafka cluster using SASL/SCRAM |
| <a name="output_bootstrap_brokers_tls"></a> [bootstrap\_brokers\_tls](#output\_bootstrap\_brokers\_tls) | Comma separated list of one or more DNS names (or IP addresses) and TLS port pairs for access to the Kafka cluster using TLS |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | Amazon Resource Name (ARN) of the MSK cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | MSK Cluster name |
| <a name="output_config_arn"></a> [config\_arn](#output\_config\_arn) | Amazon Resource Name (ARN) of the MSK configuration |
| <a name="output_current_version"></a> [current\_version](#output\_current\_version) | Current version of the MSK Cluster |
| <a name="output_latest_revision"></a> [latest\_revision](#output\_latest\_revision) | Latest revision of the MSK configuration |
| <a name="output_storage_mode"></a> [storage\_mode](#output\_storage\_mode) | Storage mode for supported storage tiers |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string) | Comma separated list of one or more hostname:port pairs to connect to the Apache Zookeeper cluster |
| <a name="output_zookeeper_connect_string_tls"></a> [zookeeper\_connect\_string\_tls](#output\_zookeeper\_connect\_string\_tls) | Comma separated list of one or more hostname:port pairs to connect to the Apache Zookeeper cluster via TLS |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
