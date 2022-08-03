# Backend configuration is loaded early so we can't use variables


terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "fast-react-static-renderer-operations-global-tools-state"
    # TODO: reset on merge to main
    key     = "fast-react-static-renderer-operations-global-tools-nodom"
    encrypt = true #AES-256encryption
  }
}