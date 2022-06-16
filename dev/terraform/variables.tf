variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default = "fast-react-static-renderer-sites-dev"
}

variable "domain_name" {
  type        = string
  description = "The domain name."
  default = "dev.frsr.bitovi.com"
}