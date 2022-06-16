resource "aws_ecr_repository" "bitovi" {
  name                 = "fast-react-static-renderer-build-image"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}