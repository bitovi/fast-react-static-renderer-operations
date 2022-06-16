provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}