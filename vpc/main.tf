# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "vpc" {
  source     = "terraform-aws-modules/vpc/aws"
  version    = "~> 5.0"
  create_vpc = true

  name = "${var.organization}-${var.environment}-bastion"

  cidr            = var.vpc_cidr
  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway   = var.vpc_enable_nat_gateway
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  single_nat_gateway = true

  flow_log_file_format = "parquet"

  tags = var.tags
}

###################################################################
# SSM Messages VPC endpoint
###################################################################
resource "aws_security_group" "vpc_bastion_sg" {
  #checkov:skip=CKV2_AWS_5:SG is used in VPC Endpoint and will be used by EC2 but not in this module
  name        = "${var.organization}-${var.environment}-sg"
  description = "Security group for bastion host"
  vpc_id      = module.vpc.vpc_id

  tags = var.tags
}
