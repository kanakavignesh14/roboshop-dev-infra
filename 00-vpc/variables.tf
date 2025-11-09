variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "project_name" {
    default = "roboshop"

}

variable "environment" {
    default = "dev"
}

variable "vpc_tags_extra" {
    default = {
        Purpose = "Roboshop vpc"
        Dontdelelte = " true"
    }
}

variable "public_subnets_cidrs" {
    default = ["10.0.1.0/24","10.0.2.0/24"]

}

variable "private_subnets_cidrs" {
    default = ["10.0.11.0/24","10.0.12.0/24"]

}

variable "database_subnets_cidrs" {
    default = ["10.0.21.0/24","10.0.22.0/24"]

}

