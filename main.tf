# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# ------------------------------------------------------------------------------
# VPC host module
# ------------------------------------------------------------------------------
module "vpc" {
  source = "./vpc"

  organization = var.organization
  environment  = var.environment
  region       = var.region

  vpc_enable_nat_gateway   = var.vpc_enable_nat_gateway
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
  vpc_enable_dns_support   = var.vpc_enable_dns_support
  vpc_enable_vpn_gateway   = var.vpc_enable_vpn_gateway
  vpc_cidr                 = var.vpc_cidr
  vpc_private_subnets      = var.vpc_private_subnets
  vpc_azs                  = [data.aws_availability_zones.available.names[0]]

  tags = local.tags
}

# ------------------------------------------------------------------------------
# Bastion host module
# ------------------------------------------------------------------------------
module "host" {
  source = "./host"

  organization = var.organization
  environment  = var.environment
  region       = var.region

  subnet_id                       = module.vpc.private_subnet_id
  bastion_host_security_group_ids = [module.vpc.vpc_host_sg]
  instance_type                   = var.instance_type

  tags = local.tags

  depends_on = [
    module.vpc
  ]
}

locals {
  tags = {
    Environment  = "${var.environment}"
    Organization = "${var.organization}"
    Region       = "${var.region}"
  }
}
