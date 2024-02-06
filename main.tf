locals {
  enabled = module.this.enabled
}
resource "aws_msk_configuration" "config" {
  count = local.enabled && var.configuration_name != null ? 1 : 0

  kafka_versions = var.config_kafka_versions
  name           = var.configuration_name
  description    = var.configuration_description

  server_properties = join("\n", [for k in keys(var.server_properties) : format("%s = %s", k, var.server_properties[k])])

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  client_auth = (var.client_allow_unauthenticated || var.client_tls_auth_enabled || var.client_sasl_scram_enabled || var.client_sasl_iam_enabled) ? [1] : []
}


resource "aws_msk_cluster" "default" {
  count = local.enabled ? 1 : 0

  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes
  enhanced_monitoring    = var.enhanced_monitoring

  broker_node_group_info {
    instance_type  = var.broker_instance_type
    client_subnets = coalesce(var.subnet_ids, data.aws_subnet.default[*].id, [])

    security_groups = var.security_groups


    storage_info {
      ebs_storage_info {
        volume_size = var.broker_volume_size
        dynamic "provisioned_throughput" {
          for_each = var.provisioned_throughput
          content {
            enabled           = provisioned_throughput.value.enabled
            volume_throughput = try(provisioned_throughput.value.volume_throughput, null)
          }
        }
      }
    }

    connectivity_info {
      public_access {
        type = var.public_access_enabled ? "SERVICE_PROVIDED_EIPS" : "DISABLED"
      }
    }
  }

  dynamic "configuration_info" {
    for_each = var.configuration_name != null ? [1] : []
    content {
      arn      = aws_msk_configuration.config[0].arn
      revision = aws_msk_configuration.config[0].latest_revision
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.client_broker
      in_cluster    = var.encryption_in_cluster
    }
    encryption_at_rest_kms_key_arn = var.encryption_at_rest_kms_key_arn
  }

  dynamic "client_authentication" {
    for_each = var.client_authentication
    content {
      unauthenticated = client_authentication.value.unauthenticated

      dynamic "tls" {
        for_each = client_authentication.value.tls
        content {
          certificate_authority_arns = tls.value.certificate_authority_arns
        }
      }


      dynamic "sasl" {
        for_each = client_authentication.value.sasl
        content {
          scram = sasl.value.scram
          iam   = sasl.value.iam
        }
      }

    }
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.jmx_exporter_enabled
      }
      node_exporter {
        enabled_in_broker = var.node_exporter_enabled
      }
    }
  }

  dynamic "logging_info" {
    for_each = var.cloudwatch_logs_enabled || var.firehose_logs_enabled || var.s3_logs_enabled ? [1] : []
    content {
      broker_logs {

        dynamic "cloudwatch_logs" {
          for_each = var.cloudwatch_logs_enabled ? [1] : []
          content {
            enabled   = true
            log_group = var.cloudwatch_logs_log_group
          }
        }

        dynamic "firehose" {
          for_each = var.firehose_logs_enabled ? [1] : []
          content {
            enabled         = true
            delivery_stream = var.firehose_delivery_stream
          }
        }

        dynamic "s3" {
          for_each = var.s3_logs_enabled ? [1] : []
          content {
            enabled = true
            bucket  = var.s3_logs_bucket
            prefix  = var.s3_logs_prefix
          }
        }
      }
    }
  }


  lifecycle {
    ignore_changes = [
      # Ignore changes to ebs_volume_size in favor of autoscaling policy
      broker_node_group_info[0].storage_info[0].ebs_storage_info[0].volume_size,
    ]
  }

  tags = module.this.tags
}

resource "aws_appautoscaling_target" "default" {
  count = local.enabled && var.autoscaling_enabled ? 1 : 0

  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = aws_msk_cluster.default[0].arn
  scalable_dimension = var.scalable_dimension
  service_namespace  = var.service_namespace
}

resource "aws_appautoscaling_policy" "default" {
  count = local.enabled && var.autoscaling_enabled ? 1 : 0

  name               = var.appautoscaling_policy_name
  policy_type        = var.policy_type
  resource_id        = aws_msk_cluster.default[0].arn
  scalable_dimension = one(aws_appautoscaling_target.default[*].scalable_dimension)
  service_namespace  = one(aws_appautoscaling_target.default[*].service_namespace)

  target_tracking_scaling_policy_configuration {
    disable_scale_in = var.storage_autoscaling_disable_scale_in

    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    target_value = var.storage_autoscaling_target_value
  }
}
