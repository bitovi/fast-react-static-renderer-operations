#IAM USER Config
data "aws_caller_identity" "current" {}

resource "aws_iam_user" "this" {
  # TODO: reset on merge to main
  name          = "frsr-ci-user-nodom"
  force_destroy = true
  tags = {
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "global-tools"
  }
}

resource "aws_iam_access_key" "v0" {
  user = aws_iam_user.this.name
}

#policy
resource "aws_iam_policy" "s3" {
  name        = "frsr-ci-user-s3"
  description = "policy for s3"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect":"Allow",
            "Action":[
                "s3:ListBucket"
            ],
            "Resource":"arn:aws:s3:::${var.hosting_bucket_name}"
        },
        {
            "Effect":"Allow",
            "Action": "s3:*Object",
            "Resource":"arn:aws:s3:::${var.hosting_bucket_name}/*"
        },
        {
            "Effect":"Allow",
            "Action":[
                "s3:ListBucket"
            ],
            "Resource":"arn:aws:s3:::${var.bucket_name}"
        },
        {
            "Effect":"Allow",
            "Action": "s3:*Object",
            "Resource":"arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "secrets" {
  name        = "frsr-iam-ci-user-policy"
  description = "frsr-iam-ci-user-policy"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetRandomPassword",
                "secretsmanager:ListSecrets"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "secretsmanager:*",
            "Resource": "arn:aws:secretsmanager:*:${data.aws_caller_identity.current.account_id}:secret:*"
        }
    ]
}
EOF
}



resource "aws_iam_user_policy_attachment" "secrets-attach" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.secrets.arn
}


resource "aws_iam_user_policy_attachment" "s3-attach" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.s3.arn
}

output "iam_user" {
  value = aws_iam_user.this.name
}
output "iam_user_arn" {
  value = aws_iam_user.this.arn
}

output "access_key_id" {
  value = aws_iam_access_key.v0.id
}

output "secret_access_key" {
  value = aws_iam_access_key.v0.secret
}
