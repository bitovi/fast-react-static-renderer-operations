# CONTENTFUL secrets
variable "secret_arn_contentful_access_token" {
  description = "ARN for the contentful access token"
}

variable "secret_arn_contentful_space_id" {
  description = "ARN for the contentful space id"
}

# APP
variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "app_version" {
  type        = string
  description = "Application Version"
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}

# NETWORKING
variable "availability_zones" {
  description = "List of availability zones"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of private subnets"
}

# ECS
variable "image_registry_url" {
  description = "Base URL of the image registry"
}
variable "image_registry_image" {
  description = "Registry image name"
}
variable "image_registry_tag" {
  description = "Registry image tag"
}

variable "aws_region" {
  description = "AWS Region"
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}

variable "s3_bucket_contents" {
  description = "S3_BUCKET_CONTENTS env var for react"
}

variable "publish_s3_bucket" {
  description = "PUBLISH_S3_BUCKET env var for react"
}

variable "build_output_subdirectory" {
  description = "BUILD_OUTPUT_SUBDIRECTORY env var for react"
}

variable "cloudfront_distribution_id" {
  description = "CLOUDFRONT_DISTRIBUTION_ID env var for react"
}

variable "build_manager_mode" {
  description = "BUILD_MANAGER_MODE env var for build container."
}

variable "catalog_url" {
  description = "Catalog URL"
}
