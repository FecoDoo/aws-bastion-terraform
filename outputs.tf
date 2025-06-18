output "bastion_host_id" {
  value = module.host.bastion_host_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "vpc_host_sg" {
  value = module.vpc.vpc_host_sg
}
