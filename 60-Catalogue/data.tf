data "aws_ami" "joindevops" {
    owners           = ["973714476881"]
    most_recent      = true
    
    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}


data "aws_ssm_parameter" "sg_id" {
    name = "/${var.project_name}/${var.environment}/catalogue-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/private_subnet_ids"

}

data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "backend_alb_listener" {
    name = "/${var.project_name}/${var.environment}/backend_alb_listener-arn"
}