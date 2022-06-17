# Backend configuration is loaded early so we can't use variables


terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "fast-react-static-renderer-operations-build-dev"
    key     = "fast-react-static-renderer-operations-build-dev"
    encrypt = true #AES-256encryption
  }
}
