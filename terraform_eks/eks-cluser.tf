provider "kubernetes" {
  host = data.aws_eks_cluster.myapp-cluster.endpoint
  token = data.aws_eks_cluster_auth.myapp-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.myapp-cluster.certificate_authority.0.data) 
}

data "aws_eks_cluster" "myapp-cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "myapp-cluster" {
  name = module.eks.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

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
