# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
variable "organization" {}

variable "environment" {}

variable "region" {}

variable "vpc_cidr" {}

variable "vpc_private_subnets" {}

variable "vpc_public_subnets" {}

variable "vpc_azs" {}

variable "vpc_enable_nat_gateway" {}

variable "vpc_enable_dns_support" {}

variable "vpc_enable_dns_hostnames" {}

variable "tags" {
  type = map(string)
}
