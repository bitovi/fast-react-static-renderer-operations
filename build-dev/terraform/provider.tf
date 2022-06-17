terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region  = "us-east-2"
  version = "~> 2.66.0"  # version changed
}