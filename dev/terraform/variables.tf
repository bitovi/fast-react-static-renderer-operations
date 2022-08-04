variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "domain_name" {
  type        = string
  description = "The domain name."
  default     = null
}

variable "subdomain_name" {
  type        = string
  description = "Subdomain that will be used for hosted env"
  default     = null
}

variable "catalog_domain_name" {
  type        = string
  description = "Subdomain that will be used for hosted env catalog"
  default     = null
}

variable "hosted_zone_id" {
  type        = string
  description = "Hostedzone ID created in global-tools for domain name"
  default     = null
}