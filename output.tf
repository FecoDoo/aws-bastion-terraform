# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "bastion_host_instance_id" {
  value = module.bastion-host.bastion_host_instance_id
}