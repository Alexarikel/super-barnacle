provider "aws" {
  region = var.region
}

data "aws_availability_zones" "azs" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "nodegroup-vpc"
  cidr = "10.0.0.0/16"
  azs = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets_cidr
  public_subnets = var.public_subnets_cidr

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared" 
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}
