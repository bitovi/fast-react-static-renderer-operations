variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default = "fast-react-static-renderer-sites-dev"
}

variable "domain_name" {
  type        = string
  description = "The domain name."
  default = "fast-react-static-renderer.com"
}

variable "subdomain_name" {
  type = string
  description = "Subdomain that will be used for hosted env"
  default = "dev.fast-react-static-renderer.com"
}

variable "hosted_zone_id" {
  type = string
  description = "Hostedzone ID created in global-tools for domain name"
  default = "Z00497363RJ1BRXGYZES2"
}