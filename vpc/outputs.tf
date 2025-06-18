# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnets[0]
}

output "vpc_host_sg" {
  value = aws_security_group.vpc_bastion_sg.id
}
