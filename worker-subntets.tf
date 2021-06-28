## Nodes in private subnets
resource "aws_eks_node_group" "private" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.eks_cluster_name}-${var.environment}-private-node-group"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = flatten([aws_subnet.private_subnet.*.id])
  ami_type       = "AL2_x86_64"
  disk_size      = 250
  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key = var.worker-node-ssh-key
  }
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
      }
  tags = merge(map("Name", "${var.eks_cluster_name}-${var.environment}-private-node-group"), var.additional_tags)
  depends_on = [
    aws_iam_role_policy_attachment.aws_eks_worker_node_policy,
    aws_iam_role_policy_attachment.aws_eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_read_only,
  ]
}



# # Nodes in public subnet


# resource "aws_eks_node_group" "public" {
#   cluster_name    = aws_eks_cluster.main.name
#   node_group_name = "${var.node_group_name}-public"
#   node_role_arn   = aws_iam_role.eks_nodes.arn
#   subnet_ids      = flatten([aws_subnet.public_subnet.*.id])
#   ami_type       = "AL2_x86_64"
#   disk_size      = 20
#   instance_types = ["t3.medium"]
#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#       }
# tags = merge(map("Name", "${var.eks_cluster_name}-public-node-group"), var.additional_tags)
#  depends_on = [
#     aws_iam_role_policy_attachment.aws_eks_worker_node_policy,
#     aws_iam_role_policy_attachment.aws_eks_cni_policy,
#     aws_iam_role_policy_attachment.ec2_read_only,
#   ]
# }