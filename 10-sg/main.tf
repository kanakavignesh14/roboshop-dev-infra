module "sg" {
  count        = length(var.sg_name)
  source       = "git::https://github.com/kanakavignesh14/terraform-aws-sg.git?ref=main"
  project_name  = var.project_name
  environment  = var.environment
  sg_name      = var.sg_name[count.index]
  sg_description = "created for ${var.sg_name[count.index]}"
  vpc_id       =   local.vpc_id # getting from local using data block 
}


 #Frontend accepting traffic from frontend ALB ---------> ingress rules to frontend

 #resource "aws_security_group_rule" "frontend_frontend_alb" {
  # type              = "ingress"
   #security_group_id = module.sg[9].sg_id # frontend SG ID
   #source_security_group_id = module.sg[11].sg_id # frontend-LB SG ID
   #from_port         = 80
   #protocol          = "tcp"
   #to_port           = 80
#}