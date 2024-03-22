resource "aws_ecr_repository" "crypto-tracker" {
  name                 = "crypto-tracker"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}