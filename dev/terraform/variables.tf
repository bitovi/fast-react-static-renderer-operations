variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default = "ya-fast-react-static-renderer-sites-dev"
}

variable "domain_name" {
  type        = string
  description = "The domain name."
  default = "ya-fast-react-static-renderer.com"
}

variable "subdomain_name" {
  type = string
  description = "Subdomain that will be used for hosted env"
  default = "dev.ya-fast-react-static-renderer.com"
}

variable "catalog_domain_name" {
  type = string
  description = "Subdomain that will be used for hosted env catalog"
  default = "catalog-dev.fast-react-static-renderer.com"
}

variable "hosted_zone_id" {
  type = string
  description = "Hostedzone ID created in global-tools for domain name"
  default = "Z09768261LFU7OL6902KA"
}