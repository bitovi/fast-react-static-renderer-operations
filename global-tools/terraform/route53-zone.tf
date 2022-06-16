resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = {
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "global-tools"
  }
}
