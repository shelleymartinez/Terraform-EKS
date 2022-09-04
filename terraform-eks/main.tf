
resource "random_string" "eks" {
  length = 5
 }

module "networking" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  
  availability_zones = ["us-west-1a", "us-west-1b"]
  name_prefix = "eks_network"
  private_subnets_cidrs_per_availability_zone = ["10.0.3.0/24", "10.0.4.0/24"]
  public_subnets_cidrs_per_availability_zone = ["10.0.1.0/24", "10.0.2.0/24"]
  vpc_cidr_block = "10.0.0.0/16"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name = "${random_string.eks.result}"
  vpc_id       = module.networking.vpc_id
  subnet_ids   = module.networking.private_subnets_ids

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 2
      max_size     = 2
      desired_size = 2

      instance_types = ["t2.micro"]
      capacity_type  = "SPOT"
    }
  }

  manage_aws_auth_configmap = false
}