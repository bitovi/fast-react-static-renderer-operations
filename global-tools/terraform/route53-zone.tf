resource "aws_route53_zone" "main" {
  count = var.domain_name ? 0 : 1
  name = var.domain_name
  tags = {
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "global-tools"
  }
}