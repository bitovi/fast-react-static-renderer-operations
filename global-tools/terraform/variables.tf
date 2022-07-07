variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default = "fast-react-static-renderer-artifacts"
}

variable "hosting_bucket_name" {
  type        = string
  description = "The name of the bucket for static content."
  default = "fast-react-static-renderer-sites-dev"
}

variable "domain_name" {
  type        = string
  description = "The domain name."
  default = "fast-react-static-renderer.com"
}