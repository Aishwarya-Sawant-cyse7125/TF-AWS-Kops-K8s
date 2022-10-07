provider "aws" {
  region    = var.region
  profile   = var.profile
}

# terraform {
#   backend "kubernetes-s3" {
#     bucket  = "kubernetes-aws-state"
#     key     = "default.tfstate"
#     region  = "us-east-1"
#   }
# }

# module "networking" {
#   source            = "./networking"
#   vpc_cidr          = "10.0.0.0/16"
#   vpc_name          = "vpc-network"
#   private_subnet_1  = "10.0.0.1/24"
#   clustername       = "kub-cluster"
# }

module "tf-aws-kops-env" {
  source            = "./tf-aws-kops-env"
}