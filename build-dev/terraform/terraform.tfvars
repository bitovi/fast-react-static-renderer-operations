# CONTENTFUL secrets
secret_arn_contentful_access_token = "arn:aws:secretsmanager:us-east-2:368433847371:secret:ContentfulAccessToken-NIU3zI"
secret_arn_contentful_space_id = "arn:aws:secretsmanager:us-east-2:368433847371:secret:ContentfulSpaceID-FXm2ED"

# APP
app_name        = "fast-react-static-renderer"
app_environment = "build-dev"
app_version     = "devops"
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
image_registry_url      =  "368433847371.dkr.ecr.us-west-2.amazonaws.com"
# TODO: Replace with new image after created
image_registry_image    =  "ecom"
image_registry_tag      =  "build-manager"
aws_region  = "us-east-2"
s3_bucket_contents  = "fast-react-static-renderer-operations-build-dev"
publish_s3_bucket   = "fast-react-static-renderer-sites-dev"
build_output_subdirectory   = "out"
# TODO: Dynamic
cloudfront_distribution_id  = "EZQD6UR6P1GRP"
build_manager_mode  = "1"
catalog_url = "https://catalog.bitovi-tgif.com/menu.json"