variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "domain_name" {
  type        = string
  description = "The domain name."
}

variable "subdomain_name" {
  type = string
  description = "Subdomain that will be used for hosted env"
}

variable "catalog_domain_name" {
  type = string
  description = "Subdomain that will be used for hosted env catalog"
}

variable "hosted_zone_id" {
  type = string
  description = "Hostedzone ID created in global-tools for domain name"
}