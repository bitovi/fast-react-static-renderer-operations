variable "bucket_name" {
  type        = string
  description = "[REQUIRED] The name of the bucket without the www. prefix. Normally domain_name."
}
variable "hosted_zone_id" {
  type        = string
  description = "[REQUIRED] Hostedzone ID created in global-tools for domain name"
  default     = null
}

variable "domain_name" {
  type        = string
  description = "[OPTIONAL] The domain name."
  default     = null
}

variable "subdomain_name" {
  type        = string
  description = "[OPTIONAL] Subdomain that will be used for hosted env"
  default     = null
}

variable "common_tags" {
  type        = any
  description = "[OPTIONAL] common tags to apply to all resources"
  default     = null
}
