# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-*-x86_64"]
  }
}

locals {
  tags = {
    Environment  = "${var.environment}"
    Organization = "${var.organization}"
    Region       = "${var.region}"
  }
}
