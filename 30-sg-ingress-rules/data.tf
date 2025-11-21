data "aws_ssm_parameter" "backend-ALB-sg_id"  {
    name = "/${var.project_name}/${var.environment}/backend-ALB-sg_id"
}

data "aws_ssm_parameter" "bastion-sg_id"  {
    name = "/${var.project_name}/${var.environment}/bastion-sg_id"
}

data "aws_ssm_parameter" "mongodb-sg_id" {
    name = "/${var.project_name}/${var.environment}/mongodb-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "redis-sg_id" {
    name = "/${var.project_name}/${var.environment}/redis-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "rabbitmq-sg_id" {
    name = "/${var.project_name}/${var.environment}/rabbitmq-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "mysql-sg_id" {
    name = "/${var.project_name}/${var.environment}/mysql-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "catalogue-sg_id" {
    name = "/${var.project_name}/${var.environment}/catalogue-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "user-sg_id" {
    name = "/${var.project_name}/${var.environment}/user-sg_id" 

}

data "aws_ssm_parameter" "cart-sg_id" {
    name = "/${var.project_name}/${var.environment}/cart-sg_id" 

}

data "aws_ssm_parameter" "shipping-sg_id" {
    name = "/${var.project_name}/${var.environment}/shipping-sg_id" 

}

data "aws_ssm_parameter" "payment-sg_id" {
    name = "/${var.project_name}/${var.environment}/payment-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "frontend-sg_id" {
    name = "/${var.project_name}/${var.environment}/frontend-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "backend_alb-sg_id" {
    name = "/${var.project_name}/${var.environment}/backend-ALB-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "frontend-lb-sg_id" {
    name = "/${var.project_name}/${var.environment}/frontend-lb-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}

data "aws_ssm_parameter" "openvpn-sg_id" {
    name = "/${var.project_name}/${var.environment}/openvpn-sg_id" # we are getting security_group_id for mongodb which we created using sg module and stored it ssm parameter, now here we fetching using data sources

}