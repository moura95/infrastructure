resource "aws_autoscaling_group" "infra_ecs_cluster_devcluster_9ba78d19_ecsautoscalinggroup_1a2hg3uy8d3ah" {
  availability_zones = ["sa-east-1a"]
  max_size                = 1
  min_size                = 1
  desired_capacity = 1
  launch_template {
      id      = aws_launch_template.lt_0b1edd8807f267576.id
      version = "$Latest"
    }

}

resource "aws_autoscaling_policy" "infra_ecs_cluster_devcluster_9ba78d19_ecsautoscalinggroup_1a2hg3uy8d3ah_ecsmanagedautoscalingpolicy_ceaa443b_f602_4258_a388_edcf8c8f2f28" {
  autoscaling_group_name    = aws_autoscaling_group.infra_ecs_cluster_devcluster_9ba78d19_ecsautoscalinggroup_1a2hg3uy8d3ah.name
  estimated_instance_warmup = 300
  name                      = "ECSManagedAutoScalingPolicy-ceaa443b-f602-4258-a388-edcf8c8f2f28"
  policy_type               = "TargetTrackingScaling"
  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = "CapacityProviderName"
        value = "Infra-ECS-Cluster-DevCluster-9ba78d19-EC2CapacityProvider-vdjZpXu1m5hs"
      }

      metric_dimension {
        name  = "ClusterName"
        value = "DevCluster"
      }

      metric_name = "CapacityProviderReservation"
      namespace   = "AWS/ECS/ManagedScaling"
      statistic   = "Average"
    }

    target_value = 100
  }

}

