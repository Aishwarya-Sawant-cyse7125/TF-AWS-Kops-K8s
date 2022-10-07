output "region" {
  value = "us-east-1"
}

# output "vpc_id" {
#   value = module.networking.vpc_id
# }

output "random_string" {
  value = module.tf-aws-kops-env.random_string
}

output "cluster_name" {
  value = "prd.aws.rolwynquadras.me"
}