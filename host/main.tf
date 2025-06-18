# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_instance" "bastion_host" {
  ami                     = data.aws_ami.ami.id
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.bastion_host_security_group_ids
  iam_instance_profile    = aws_iam_instance_profile.bastion_host.name
  disable_api_termination = true

  root_block_device {
    encrypted = false
  }

  #checkov:skip=CKV_AWS_135:t3.nano have ebs_optimization enabled by default
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html
  monitoring = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = templatefile("${path.root}/data/user_data.sh", {})

  tags = var.tags
}
