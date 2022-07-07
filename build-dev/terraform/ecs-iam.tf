data "aws_caller_identity" "current" {}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.app_name}-execution-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = merge(var.common_tags,{
    Name        = "${var.app_name}-iam-role"
  })
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


# attach the ci-user policy (see global-tools/terraform/iam-ci-user.tf)
resource "aws_iam_role_policy_attachment" "build_ci_user_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/frsr-ci-user-s3"
}

# attach a policy to invalidate the cloudfront cache
resource "aws_iam_policy" "cloudfront" {
  name = "${var.app_name}-build-dev-cloudfront-invalidation"

  # angular
  # "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/E34450W1O9P7SH",
  # react
  # "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/E1P5X4XDUERR45",
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudfront:CreateInvalidation",
        "cloudfront:GetInvalidation",
        "cloudfront:ListInvalidations"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/*"
      ]
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = aws_iam_policy.cloudfront.arn
}


# attach a policy to run sub-build tasks
resource "aws_iam_policy" "ecs-runner" {
  name = "${var.app_name}-build-dev-ecs-runner"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ecsRunnerPolicy",
      "Action": [
        "ecs:RunTask",
        "ecs:DescribeTasks"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ecs:us-east-2:${data.aws_caller_identity.current.account_id}:task-definition/fast-react-static-renderer-task:*",
        "arn:aws:ecs:us-east-2:${data.aws_caller_identity.current.account_id}:task/fast-react-static-renderer-build-dev-cluster/*"
      ]
    },
    {
      "Sid": "iamPolicy",
      "Action": [
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "test-attach-1" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = aws_iam_policy.ecs-runner.arn
}
