# REQUIRED PARAMITERS
# S3
bucket_name = "fast-react-static-renderer-artifacts"
hosting_bucket_name = "fast-react-static-renderer-sites-dev"

# OPTIONAL PARAMITERS
common_tags = {
  terraform                 = "true"
  OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
  OperationsRepoEnvironment = "global-tools"
}


# Domain
# domain_name = "fast-react-static-renderer.com"