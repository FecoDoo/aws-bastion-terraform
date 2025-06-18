# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_iam_role" "bastion_host" {
  name_prefix = "${var.organization}-${var.environment}-bastion-host"
  description = "IAM role for the bastion host instance"

  max_session_duration = 43200 # 12 hours
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "bastion_host" {
  for_each = toset(local.bastion_host_policy.managed_policy_arns)

  role       = aws_iam_role.bastion_host.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "bastion_host" {
  role = aws_iam_role.bastion_host.name

  tags = var.tags
}

locals {
  bastion_host_policy = {
    managed_policy_arns = [
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
      "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
      "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
}