data "aws_eks_cluster" "myapp-cluster" {
  name = module.eks.cluster_name
}

output "db_instance_addr" {
  description = "address of the db instance"
  value       = aws_db_instance.database.endpoint
}

output "eks_cluster_endpoint" {
  description = "API server endpoint"
  value       = data.aws_eks_cluster.myapp-cluster.endpoint
}
