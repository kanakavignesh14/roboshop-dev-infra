module "vpc" {
    #source = "../terraform-aws-vpc"
    source = "git::https://github.com/kanakavignesh14/terraform-aws-vpc.git?ref=main"
    #vpc_cidr = "10.0.0.0/16"
    #project_name = "roboshop"
    #environment = "dev"

    # VPC
    vpc_cidr = var.vpc_cidr
    project_name = var.project_name
    environment = var.environment   
    vpc_tags_extra  = var.vpc_tags_extra   # if u want any extra tags for your project need you can  specify here 
    
     # public subnets
    public_subnets_cidrs = var.public_subnets_cidrs


     # private subnets
    private_subnets_cidrs = var.private_subnets_cidrs


     # database subnets
    database_subnets_cidrs = var.database_subnets_cidrs

    peering_required = "true"





}