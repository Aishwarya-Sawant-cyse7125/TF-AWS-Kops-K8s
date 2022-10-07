resource "aws_vpc" "vpc" {
  cidr_block            = var.vpc_cidr
  enable_dns_hostnames  = true
  enable_dns_support    = true
  instance_tenancy      = "default"
  tags = {
    Name = var.vpc_name
  }
}

# resource "aws_vpc_dhcp_options" "dhcp_options" {
#   domain_name = "${var.region}.compute.internal"
#   domain_name_servers = ["AmazonProvidedDNS"]
# }

