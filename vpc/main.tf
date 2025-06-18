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

  enable_nat_gateway   = var.vpc_enable_nat_gateway
  enable_vpn_gateway   = var.vpc_enable_vpn_gateway
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

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
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow traffic on all ports and ip ranges"
  }
}


resource "aws_vpc_endpoint" "vpc_ssmmessages_vpce" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_ssmmessages_endpoint_sg.id]

  tags = var.tags
}

resource "aws_security_group" "vpc_ssmmessages_endpoint_sg" {
  name        = "${var.organization}-${var.environment}-ssmmessages-sg"
  description = "Security group for SSM Messages VPC endpoint"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "vpc_ssmmessages_endpoint_sge" {
  security_group_id        = aws_security_group.vpc_ssmmessages_endpoint_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.vpc_bastion_sg.id
  description              = "vpc ssm messages vpce security group ingress rule"
}

###################################################################
# EC2 Messages VPC endpoint
###################################################################

resource "aws_vpc_endpoint" "vpc_ec2messages_vpce" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_ec2messages_endpoint_sg.id]

  tags = var.tags
}

resource "aws_security_group" "vpc_ec2messages_endpoint_sg" {
  name        = "${var.organization}-${var.environment}-ec2messages-sg"
  description = "Security group for EC2 Messages VPC endpoint"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "vpc_ec2messages_endpoint_sg" {
  security_group_id        = aws_security_group.vpc_ec2messages_endpoint_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.vpc_bastion_sg.id
  description              = "vpc ec2 messages vpce security group ingress rule"
}

###################################################################
# SSM VPC endpoint
###################################################################
#
resource "aws_vpc_endpoint" "vpc_ssm_vpce" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_ssm_endpoint_sg.id]

  tags = var.tags
}

resource "aws_security_group" "vpc_ssm_endpoint_sg" {
  name        = "${var.organization}-${var.environment}-ssm-sg"
  description = "Security group for SSM VPC endpoint"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "vpc_ssm_endpoint_sg" {
  security_group_id        = aws_security_group.vpc_ssm_endpoint_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.vpc_bastion_sg.id
  description              = "vpc ssm vpce security group ingress rule for bastion host"
}

