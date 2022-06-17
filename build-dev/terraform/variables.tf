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