# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "bastion_host_instance_id" {
  value = aws_instance.bastion_host_ec2_instance.id
}

output "bastion_host_public_ip" {
  value = aws_eip.bastion.public_ip
}
