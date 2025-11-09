output "vpc_id" {
    value = module.vpc.vpc_id    # module name vpc will send . so we recive to this vpc module name check in main.tf
}


output "public_subnet_ids" {
    value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
    value = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
    value = module.vpc.database_subnet_ids
}