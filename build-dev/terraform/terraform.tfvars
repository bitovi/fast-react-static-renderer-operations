# CONTENTFUL secrets
secret_arn_contentful_access_token = "arn:aws:secretsmanager:us-east-2:368433847371:secret:ContentfulAccessToken-NIU3zI"
secret_arn_contentful_space_id = "arn:aws:secretsmanager:us-east-2:368433847371:secret:ContentfulSpaceID-FXm2ED"

# APP
app_name        = "fast-react-static-renderer"
app_environment = "build-dev"
common_tags = {
  OperationsRepo = "bitovi/fast-react-static-renderer-operations"
  OperationsRepoEnvironment = "build-dev"
}

# NETWORK
availability_zones = ["us-east-2a","us-east-2b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]