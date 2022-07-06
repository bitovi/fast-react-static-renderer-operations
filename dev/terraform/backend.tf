# Backend configuration is loaded early so we can't use variables


terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "ya-fast-react-static-renderer-operations-dev-state"
    key     = "fast-react-static-renderer-operations-dev"
    encrypt = true #AES-256encryption
  }
}
