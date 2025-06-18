# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
variable "organization" {}

variable "environment" {}

variable "region" {}

variable "subnet_id" {}

variable "bastion_host_security_group_ids" {}

variable "instance_type" {
  type    = string
  default = "t3.nano"
}

variable "tags" {
  type = map(string)
}
