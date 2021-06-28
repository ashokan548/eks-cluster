# access_key = ""
# secret_key = ""
region              = "eu-central-1"
eks_cluster_name    = "demo"
environment         = "dev"
vpc_cidr_block      = "10.68.0.0/16"
availability_zones  = ["eu-central-1a", "eu-central-1b"]
public_subnet_cidr_blocks = ["10.68.1.0/24", "10.68.2.0/24"]
private_subnet_cidr_block = ["10.68.3.0/24", "10.68.4.0/24"]
worker-node-ssh-key = "fr-key"
eks-cw-logging      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
additional_tags = {
    ProvisionBy = "Terraform"
    Environment = "staging"
}

