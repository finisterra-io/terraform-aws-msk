variable "enabled" {
  type        = bool
  description = "Set to `true` to enable the MSK cluster"
  default     = true
}

variable "cluster_name" {
  type        = string
  description = "The name of the MSK cluster"
  nullable    = false
}

variable "kafka_version" {
  type        = string
  description = <<-EOT
  The desired Kafka software version.
  Refer to https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html for more details
  EOT
  nullable    = false
}

variable "broker_instance_type" {
  type        = string
  description = "The instance type to use for the Kafka brokers"
  nullable    = false
}

variable "broker_per_zone" {
  type        = number
  default     = 1
  description = "Number of Kafka brokers per zone"
  validation {
    condition     = var.broker_per_zone > 0
    error_message = "The broker_per_zone value must be at least 1."
  }
  nullable = false
}

variable "broker_volume_size" {
  type        = number
  default     = 1000
  description = "The size in GiB of the EBS volume for the data drive on each broker node"
  nullable    = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for Client Broker"
  default     = null
}

variable "subnet_names" {
  type        = list(string)
  description = "Subnet names for Client Broker"
  default     = null
}

variable "client_broker" {
  type        = string
  default     = "TLS"
  description = "Encryption setting for data in transit between clients and brokers. Valid values: `TLS`, `TLS_PLAINTEXT`, and `PLAINTEXT`"
  nullable    = false
}

variable "encryption_in_cluster" {
  type        = bool
  default     = true
  description = "Whether data communication among broker nodes is encrypted"
  nullable    = false
}

variable "encryption_at_rest_kms_key_arn" {
  type        = string
  default     = ""
  description = "You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest"
}

variable "enhanced_monitoring" {
  type        = string
  default     = "DEFAULT"
  description = "Specify the desired enhanced MSK CloudWatch monitoring level. Valid values: `DEFAULT`, `PER_BROKER`, and `PER_TOPIC_PER_BROKER`"
  nullable    = false
}

variable "jmx_exporter_enabled" {
  type        = bool
  default     = false
  description = "Set `true` to enable the JMX Exporter"
  nullable    = false
}

variable "node_exporter_enabled" {
  type        = bool
  default     = false
  description = "Set `true` to enable the Node Exporter"
  nullable    = false
}

variable "cloudwatch_logs_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs"
  nullable    = false
}

variable "cloudwatch_logs_log_group" {
  type        = string
  default     = null
  description = "Name of the Cloudwatch Log Group to deliver logs to"
}

variable "firehose_logs_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose"
  nullable    = false
}

variable "firehose_delivery_stream" {
  type        = string
  default     = ""
  description = "Name of the Kinesis Data Firehose delivery stream to deliver logs to"
}

variable "s3_logs_enabled" {
  type        = bool
  default     = false
  description = " Indicates whether you want to enable or disable streaming broker logs to S3"
  nullable    = false
}

variable "s3_logs_bucket" {
  type        = string
  default     = ""
  description = "Name of the S3 bucket to deliver logs to"
}

variable "s3_logs_prefix" {
  type        = string
  default     = ""
  description = "Prefix to append to the S3 folder name logs are delivered to"
}

variable "server_properties" {
  type        = map(string)
  default     = {}
  description = "Contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html)"
  nullable    = false
}

variable "autoscaling_enabled" {
  type        = bool
  default     = true
  description = "To automatically expand your cluster's storage in response to increased usage, you can enable this. [More info](https://docs.aws.amazon.com/msk/latest/developerguide/msk-autoexpand.html)"
  nullable    = false
}

variable "storage_autoscaling_target_value" {
  type        = number
  default     = null
  description = "Percentage of storage used to trigger autoscaled storage increase"
}

variable "storage_autoscaling_disable_scale_in" {
  type        = bool
  default     = false
  description = "If the value is true, scale in is disabled and the target tracking policy won't remove capacity from the scalable resource"
  nullable    = false
}

variable "public_access_enabled" {
  type        = bool
  default     = false
  description = "Enable public access to MSK cluster (given that all of the requirements are met)"
  nullable    = false
}

variable "number_of_broker_nodes" {
  type        = number
  description = "The number of broker nodes in the cluster"
  nullable    = false
}

variable "configuration_name" {
  type        = string
  description = "The name of the configuration to use for the cluster"
  default     = null
}

variable "configuration_description" {
  type        = string
  description = "The description of the configuration to use for the cluster"
  default     = null
}

variable "max_capacity" {
  type        = number
  description = "The maximum capacity of the cluster"
  default     = null
}

variable "min_capacity" {
  type        = number
  description = "The minimum capacity of the cluster"
  default     = null
}

variable "scalable_dimension" {
  type        = string
  description = "The scalable dimension of the cluster"
  default     = null
}

variable "service_namespace" {
  type        = string
  description = "The service namespace of the cluster"
  default     = null
}

variable "appautoscaling_policy_name" {
  type        = string
  description = "The name of the policy to use for the cluster"
  default     = null
}

variable "policy_type" {
  type        = string
  description = "The policy type of the cluster"
  default     = null
}

variable "predefined_metric_type" {
  type        = string
  description = "The predefined metric type of the cluster"
  default     = null
}

variable "provisioned_throughput" {
  type        = list(any)
  description = "The provisioned throughput of the cluster"
  default     = []
}

variable "client_authentication" {
  type        = list(any)
  description = "The client authentication of the cluster"
  default     = []
}

variable "config_kafka_versions" {
  type        = list(any)
  description = "The config kafka versions of the cluster"
  default     = []
}

variable "security_groups" {
  type        = list(any)
  description = "The security groups of the cluster"
  default     = []
}


variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "autoscalling_target_tags" {
  type        = map(string)
  description = "A map of tags to add to the autoscaling target"
  default     = {}
}
