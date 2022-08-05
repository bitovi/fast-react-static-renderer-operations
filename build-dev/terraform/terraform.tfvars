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
# TODO: Replace with new image after created
# image_registry_url      =  ""
# TODO: Replace with new image after created
image_registry_org      =  "bitovi"
image_registry_image    =  "fast-react-static-renderer-build"
image_registry_tag      =  "dev"
aws_region  = "us-east-2"
s3_bucket_contents  = "fast-react-static-renderer-artifacts"
publish_s3_bucket   = "fast-react-static-renderer-sites-dev"
build_output_subdirectory   = "out"
cloudfront_distribution_id  = "EZQD6UR6P1GRP"
build_manager_mode  = "1"

# OPTIONAL PARAMITERS
catalog_url = "https://catalog-dev.fast-react-static-renderer.com/"