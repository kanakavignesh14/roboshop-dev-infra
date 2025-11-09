data "aws_ssm_parameter" "backend-ALB-sg_id"  {
    name = "/${var.project_name}/${var.environment}/backend-ALB-sg_id"
}

data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"  # we are sending name it will fetch value from ssm_parameter
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}