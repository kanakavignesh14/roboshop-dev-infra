data "aws_ssm_parameter" "frontend-lb-sg_id"  {
    name = "/${var.project_name}/${var.environment}/frontend-lb-sg_id"
}

data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"  # we are sending name it will fetch value from ssm_parameter
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}


data "aws_ssm_parameter" "frontend_alb_certificate_arn" { # our certificate arn
  name  = "/${var.project_name}/${var.environment}/frontend_alb_certificate_arn"
}