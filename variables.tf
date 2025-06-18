variable "vpc_enable_nat_gateway" {}

variable "vpc_enable_vpn_gateway" {}

variable "vpc_enable_dns_support" {}

variable "vpc_enable_dns_hostnames" {}

variable "instance_type" {}

variable "vpc_cidr" {}

variable "vpc_private_subnets" {}

variable "organization" {}

variable "environment" {
  description = "The name of the organization."
  default     = "bastion"
}

variable "region" {
  description = "The AWS region where the resources will be created."
  default     = "eu-west-1"
}
