resource "aws_ecr_repository" "vagasaservice_website_repo" {
  name                 = "vagasaservice-website-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}