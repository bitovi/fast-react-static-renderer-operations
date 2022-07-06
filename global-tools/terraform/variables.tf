variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default = "ya-fast-react-static-renderer-artifacts"
}

variable "domain_name" {
  type        = string
  description = "The domain name."
  default = "ya-fast-react-static-renderer.com"
}