variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "hosting_bucket_name" {
  type        = string
  description = "The name of the bucket for static content."
}

variable "domain_name" {
  type        = string
  description = "The domain name."
  default     = null
}