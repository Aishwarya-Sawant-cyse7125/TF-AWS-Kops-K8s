output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cluster_name" {
  value = var.clustername
}