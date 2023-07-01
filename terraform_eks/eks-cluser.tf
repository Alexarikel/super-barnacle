module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_endpoint_public_access = true

  cluster_name = "myapp-eks-cluster"
  cluster_version = "1.27"

  subnet_ids = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

  tags = {
    environment = "development"
  }

  eks_managed_node_groups = {
    one = {
      instance_types = ["t3.medium"]
      name = "node-group-1"
      min_size = 1
      max_size = 3
      desired_size = 2
    }
  } 
}
