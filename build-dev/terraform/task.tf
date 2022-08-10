resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.app_name}-${var.app_environment}-logs"

  tags = merge(var.common_tags,{
    Application = var.app_name
  })
}

resource "aws_ecs_task_definition" "build_manager_task" {
  family = "${var.app_name}-buildmanager-task"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.app_name}-${var.app_environment}-buildmanager",
      "image": "${var.image_registry_org}/${var.image_registry_image}:${var.image_registry_tag}",
      "entryPoint": [],
      "environment": [],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "${local.log_stream_prefix_timestamp}-manager"
        }
      },
      "cpu": 2048,
      "memory": 4096,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "4096"
  cpu                      = "2048"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  tags = merge(var.common_tags,{
    Name        = "${var.app_name}-ecs-td"
  })
}

resource "aws_ecs_task_definition" "build_task" {
  family = "${var.app_name}-task"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.app_name}-${var.app_environment}-container",
      "image": "${var.image_registry_org}/${var.image_registry_image}:${var.image_registry_tag}",
      "entryPoint": [],
      "environment": [],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "${local.log_stream_prefix_timestamp}-build"
        }
      },
      "cpu": 2048,
      "memory": 4096,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "4096"
  cpu                      = "2048"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  tags = merge(var.common_tags,{
    Name        = "${var.app_name}-ecs-td"
  })
}

locals {
  task_overrides = jsonencode({
    "containerOverrides": [{
      "name": "${var.app_name}-${var.app_environment}-buildmanager",
      "environment": [{
        "name": "APP_VERSION",
        "value": "${var.app_version}"
      },{
        "name": "CONTENTFUL_SPACE_ID",
        # "value": data.aws_secretsmanager_secret_version.spaceid.secret_string
        "value": "${jsondecode(data.aws_secretsmanager_secret_version.spaceid.secret_string)["ContentfulSpaceID"]}"
      },{
        "name": "CONTENTFUL_ACCESS_TOKEN",
        # "value": data.aws_secretsmanager_secret_version.access_token.secret_string
        "value": "${jsondecode(data.aws_secretsmanager_secret_version.access_token.secret_string)["ContentfulAccessToken"]}"
      # TODO: remove?
      # },{
      #   "name": "APP_SUBPATH",
      #   "value": "${var.app_subpath}"
      },{
        "name": "S3_BUCKET_CONTENTS",
        "value": "${var.s3_bucket_contents}"
      # TODO: remove?
      # },{
      #   "name": "APP_SUBPATH_PUBLISH_SUFFIX",
      #   "value": "${var.app_subpath_publish_suffix}"
      },{
        "name": "PUBLISH_S3_BUCKET",
        "value": "${var.publish_s3_bucket}"
      },{
        "name": "BUILD_OUTPUT_SUBDIRECTORY",
        "value": "${var.build_output_subdirectory}"
      },{
        "name": "CLOUDFRONT_DISTRIBUTION_ID",
        "value": "${var.cloudfront_distribution_id}"
      },{
        "name" : "PAGE_DATA",
        "value" : ""
      }, {
        "name": "BUILD_MANAGER_MODE",
        "value": "${var.build_manager_mode}"
      },{
        "name": "RETRY_SLEEP",
        "value": "${var.build_manager_retry_sleep}"
      },{
        "name": "RETRY_LIMIT",
        "value": "${var.build_manager_retry_limit}"
      },{
        "name": "PAGES_PER_CONTAINER",
        "value": "${var.build_manager_pages_per_container}"
      },{
        "name": "CONTAINER_OVERRIDE_NAME",
        "value": "${var.app_name}-${var.app_environment}-container"
      },{
        "name": "TASK_DEFINITION",
        "value": "${aws_ecs_task_definition.build_task.arn}"
      },{
        "name": "ECS_CLUSTER_NAME",
        "value": "${aws_ecs_cluster.aws-ecs-cluster.name}"
      },{
        "name": "ECS_NETWORK_CONFIG",
        "value": "${local.network_configuration}"
      }]
    }]
  })
  tags = jsonencode([{
      "key": "app-framework",
      "value": "react"
    }]
  )

  network_configuration = jsonencode({
    "awsvpcConfiguration": {
      "subnets": aws_subnet.public.*.id,
      "assignPublicIp": "ENABLED"
    }
  })

  log_stream_prefix_timestamp=formatdate("YYYY-MM-DD_hh-mm-ss", timestamp())
}

resource "null_resource" "run-build-task" {
  depends_on = [
    aws_ecs_task_definition.build_task
  ]

  # run the task
  provisioner "local-exec" {
    command = <<EOF
    aws ecs run-task \
    --cluster="${aws_ecs_cluster.aws-ecs-cluster.name}" \
    --task-definition="${aws_ecs_task_definition.build_manager_task.family}" \
    --launch-type="FARGATE" \
    --network-configuration='${local.network_configuration}' \
    --overrides='${local.task_overrides}' \
    --tags='${local.tags}'

EOF
  }

  # tag with a timestamp for cachebusting
  triggers = {
    always_run = timestamp()
  }  
}


output "ecs-log-group-id" {
  value = aws_cloudwatch_log_group.log-group.id
}
output "ecs-log-group-name" {
  value = aws_cloudwatch_log_group.log-group.name
}
output "ecs-log-group-arn" {
  value = aws_cloudwatch_log_group.log-group.arn
}
