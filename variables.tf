variable "vpc_cidr" {}

variable "vpc_enable_nat_gateway" {}

variable "vpc_enable_dns_support" {}

variable "vpc_enable_dns_hostnames" {}

variable "ami" {
  description = "AMI ID for the bastion host"
  type        = string
  default     = "ami-07b5312224c6b20e7"
}

variable "instance_type" {}

variable "organization" {}

variable "environment" {
  description = "The name of the organization."
  default     = "bastion"
}

variable "region" {
  description = "The AWS region where the resources will be created."
  default     = "eu-west-1"
}
