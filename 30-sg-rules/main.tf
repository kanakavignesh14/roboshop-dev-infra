#backend alb accepting traffic from bastion
resource "aws_security_group_rule" "backend-alb-bastion" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.backend-ALB-sg_id.value
   source_security_group_id = data.aws_ssm_parameter.bastion-sg_id.value # bastion- SG ID
   from_port         = 80
   protocol          = "tcp"
   to_port           = 80
}

# bastion accepting traffic from laptop ---> ingress rules
resource "aws_security_group_rule" "bastion-laptop" {
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.bastion-sg_id.value
   cidr_blocks = ["0.0.0.0/0"] #from internet
   from_port         = 80
   protocol          = "tcp"
   to_port           = 80
}

resource "aws_security_group_rule" "inetrnet_to_bastion" {
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.bastion-sg_id.value     #mongodg is accept (need mongodb sg id)
   cidr_blocks = ["0.0.0.0/0"]   # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}


# mongodb accepting traffic from bastion ---> ingress rules
resource "aws_security_group_rule" "bastion-mongodb" {
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.mongodb-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}

# redis accepting traffic from bastion ---> ingress rules
resource "aws_security_group_rule" "bastion-redis" {
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.redis-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}



resource "aws_security_group_rule" "bastion-rabbitmq" { # rabbitmq accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.rabbitmq-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}