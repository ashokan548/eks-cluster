resource "aws_ecr_repository" "ecr" {
  name                 = "${var.eks_cluster_name}-${var.environment}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
    tags = merge(map("Name", "${var.eks_cluster_name}-${var.environment}-ecr"), var.additional_tags)
}