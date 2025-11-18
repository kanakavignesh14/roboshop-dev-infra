resource "aws_ssm_parameter" "backend-alb-arn" {
    name = "/${var.project_name}/${var.environment}/backend_alb_listener-arn"
    type = "String"
    value = aws_lb_listener.backend_alb.arn
}