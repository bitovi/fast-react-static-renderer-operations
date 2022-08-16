# CONTENTFUL secrets
variable "secret_arn_contentful_access_token" {
  description = "[REQUIRED] ARN for the contentful access token"
}

variable "secret_arn_contentful_space_id" {
  description = "[REQUIRED] ARN for the contentful space id"
}

# APP
variable "app_name" {
  type        = string
  description = "[REQUIRED] Application Name"
}

variable "app_environment" {
  type        = string
  description = "[REQUIRED] Application Environment"
}

variable "app_version" {
  type        = string
  description = "[REQUIRED] Application Version"
}

variable "common_tags" {
  description = "[REQUIRED] Common tags you want applied to all components."
}

# NETWORKING
variable "availability_zones" {
  description = "[REQUIRED] List of availability zones"
}

variable "public_subnets" {
  description = "[REQUIRED] List of public subnets"
}

variable "private_subnets" {
  description = "[REQUIRED] List of private subnets"
}

# ECS
variable "image_registry_org" {
  description = "[REQUIRED] Regestry organization name"
}

variable "image_registry_image" {
  description = "[REQUIRED] Registry image name"
}
variable "image_registry_tag" {
  description = "[REQUIRED] Registry image tag"
}

variable "aws_region" {
  description = "[REQUIRED] AWS Region"
}

variable "s3_bucket_contents" {
  description = "[REQUIRED] S3_BUCKET_CONTENTS env var for react"
}

variable "publish_s3_bucket" {
  description = "[REQUIRED] PUBLISH_S3_BUCKET env var for react"
}

variable "build_output_subdirectory" {
  description = "[REQUIRED] BUILD_OUTPUT_SUBDIRECTORY env var for react"
}

variable "cloudfront_distribution_id" {
  description = "[REQUIRED] CLOUDFRONT_DISTRIBUTION_ID env var for react"
  default = null
}

variable "build_manager_mode" {
  description = "[OPTIONAL] BUILD_MANAGER_MODE env var for build container."
  default = "1"
}
variable "build_manager_retry_sleep" {
  description = "[OPTIONAL] RETRY_SLEEP env var for build container (time to sleep in minutes)."
  default = "2"
}
variable "build_manager_retry_limit" {
  description = "[OPTIONAL] RETRY_LIMIT env var for build container (how many times to check on status of child containers)."
  default = "20"
}
variable "build_manager_pages_per_container" {
  description = "[OPTIONAL] PAGES_PER_CONTAINER env var for build container (how many pages per child container)."
  default = "3"
}
  
  
variable "build_manager_s3_sync_extra_flags" {
  description = "[OPTIONAL] S3_SYNC_EXTRA_FLAGS_BUILD_MANAGER env var for build container (additional flags to set for the s3 sync command for the build manager)."
}
variable "child_container_s3_sync_extra_flags" {
  description = "[OPTIONAL] S3_SYNC_EXTRA_FLAGS_CHILD_CONTAINERS env var for build container (additional flags to set for the s3 sync command for the child containers)."
}
variable "child_container_use_page_data_file" {
  description = "[OPTIONAL] BUILD_USE_PAGE_DATA_FILE env var for build container (use a file approach to pass PAGE_DATA information if your page data is large - i.e. your json data would exceed the env var size limits)."
}

variable "build_manager_use_page_data_file" {
  description = "[OPTIONAL] BUILD_MANAGER_USE_PAGE_DATA_FILE env var for build manager container (use a file approach to pass PAGE_DATA information if your page data is large - i.e. your json data would exceed the env var size limits)."
}

# Benchmarking vars
variable "benchmarking_num_pages" {
  description = "[OPTIONAL] NUMBER_OF_PAGES env var for build containers (how many pages to build)."
}
