# REQUIRED PARAMITERS
# CONTENTFUL secrets
secret_arn_contentful_access_token = "arn:aws:secretsmanager:us-east-2:271557913550:secret:ContentfulAccessToken-XQ85Q0"
secret_arn_contentful_space_id = "arn:aws:secretsmanager:us-east-2:271557913550:secret:ContentfulSpaceID-68lFVR"

# APP
app_name        = "fast-react-static-renderer"
app_environment = "build-dev"
app_version     = "latest"
common_tags = {
  OperationsRepo = "bitovi/fast-react-static-renderer-operations"
  OperationsRepoEnvironment = "build-dev"
}

# NETWORK
availability_zones = ["us-east-2a","us-east-2b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]

# ECS
image_registry_org      =  "bitovi"
image_registry_image    =  "fast-react-static-renderer-build"
image_registry_tag      =  "latest"
aws_region  = "us-east-2"
s3_bucket_contents  = "fast-react-static-renderer-artifacts"
publish_s3_bucket   = "fast-react-static-renderer-sites-dev"
build_output_subdirectory   = "out"
# TODO: Dynamic
cloudfront_distribution_id  = "E2633P2JNWSIZ6"

# Build manager config
build_manager_mode  = "1"
build_manager_retry_sleep = "1"
build_manager_retry_limit = "15"
build_manager_pages_per_container = "3"

# Benchmarking config
benchmarking_num_pages = "10"