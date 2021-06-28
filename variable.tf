variable "eks_cluster_name" {}
variable "environment" {}
variable "vpc_cidr_block" {}
variable "private_subnet_cidr_block" {}
variable "public_subnet_cidr_blocks" {}
variable "availability_zones" {}
variable "region" {}
variable "worker-node-ssh-key" {}
variable "eks-cw-logging" {
  type = list(any)
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags for the Azure Firewall resources, in addition to the resource group tags."
}

# variable "access_key" {}
# variable "secret_key" {}