data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"  # we are sending name it will fetch value from ssm_parameter for vpc id
}