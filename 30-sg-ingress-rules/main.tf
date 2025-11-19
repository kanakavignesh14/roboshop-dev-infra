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

resource "aws_security_group_rule" "bastion-mysql" { # mysql accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.mysql-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}

resource "aws_security_group_rule" "bastion-catalogue" { # catalogue accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.catalogue-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}

resource "aws_security_group_rule" "bastion-cart" { # catalogue accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.cart-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}

resource "aws_security_group_rule" "bastion-user" { # catalogue accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.user-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}

resource "aws_security_group_rule" "bastion-shipping" { # catalogue accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.shipping-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}
resource "aws_security_group_rule" "bastion-payment" { # catalogue accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.payment-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}

resource "aws_security_group_rule" "bastion-frontend" { # catalogue accepting ssh connection from bastion host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.frontend-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.bastion-sg_id.value    # bastion connects to mongodb (need bastion sg id)
   from_port         = 22
   protocol          = "tcp"
   to_port           = 22
}


resource "aws_security_group_rule" "catalogue-mongodb" { # mongodb accepting ssh connection from catalogue host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.mongodb-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.catalogue-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 27017
   protocol          = "tcp"
   to_port           = 27017
}

resource "aws_security_group_rule" "user-mongodb" { # mongodb accepting ssh connection from user host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.mongodb-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.user-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 27017
   protocol          = "tcp"
   to_port           = 27017
}

resource "aws_security_group_rule" "user-redis" { # redis accepting ssh connection from user host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.redis-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.user-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 6379
   protocol          = "tcp"
   to_port           = 6379
}

resource "aws_security_group_rule" "cart-redis" { # redis accepting ssh connection from cart host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.redis-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.cart-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 6379
   protocol          = "tcp"
   to_port           = 6379
}



resource "aws_security_group_rule" "shipping-mysql" { # mysql accepting ssh connection from shipping host
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.mysql-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.shipping-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 3306
   protocol          = "tcp"
   to_port           = 3306
}

resource "aws_security_group_rule" "payment-rabbitmq" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.rabbitmq-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.payment-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 5672
   protocol          = "tcp"
   to_port           = 5672
}




resource "aws_security_group_rule" "backend_alb-catalogue" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.catalogue-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.backend-ALB-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 8080
   protocol          = "tcp"
   to_port           = 8080
}

resource "aws_security_group_rule" "backend_alb-user" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.user-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.backend-ALB-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 8080
   protocol          = "tcp"
   to_port           = 8080
}

resource "aws_security_group_rule" "backend_alb-cart" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.cart-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.backend-ALB-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 8080
   protocol          = "tcp"
   to_port           = 8080
}

resource "aws_security_group_rule" "backend_alb-shipping" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.shipping-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.backend-ALB-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 8080
   protocol          = "tcp"
   to_port           = 8080
}

resource "aws_security_group_rule" "backend_alb-payment" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.payment-sg_id.value     #mongodg is accept (need mongodb sg id)
   source_security_group_id =   data.aws_ssm_parameter.backend-ALB-sg_id.value    # catalogue connects to mongodb (need bastion sg id)
   from_port         = 8080
   protocol          = "tcp"
   to_port           = 8080
}

# connections between backend services
# here two backend services cant connet direclty they need to connect through backend load balancer
#resource "aws_security_group_rule" "cart-catalogue" { 
  # type              = "ingress"
  # security_group_id = data.aws_ssm_parameter.catalogue-sg_id.value     #catalogue is accept 
  # source_security_group_id = data.aws_ssm_parameter.cart-sg_id.value    # cart connects to catalogue 
  # from_port         = 8080
  # protocol          = "tcp"
 #  to_port           = 8080
#}


resource "aws_security_group_rule" "cart-backend_alb" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.backend-ALB-sg_id.value     #backend_alb is accept 
   source_security_group_id = data.aws_ssm_parameter.cart-sg_id.value    # cart connects to catalogue 
   from_port         = 80
   protocol          = "tcp"
   to_port           = 80
}


# we changes here shipping and cart cant talk like th they need load balncer
#resource "aws_security_group_rule" "shipping-cart" { 
  # type              = "ingress"
  # security_group_id = data.aws_ssm_parameter.cart-sg_id.value     #catalogue is accept 
  # source_security_group_id =   data.aws_ssm_parameter.shipping-sg_id.value    # cart connects to catalogue 
  # from_port         = 8080
  # protocol          = "tcp"
 #  to_port           = 8080
#}

resource "aws_security_group_rule" "shipping-backend_alb" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.backend-ALB-sg_id.value     #catalogue is accept 
   source_security_group_id = data.aws_ssm_parameter.shipping-sg_id.value    # cart connects to catalogue 
   from_port         = 80
   protocol          = "tcp"
   to_port           = 80
}


#resource "aws_security_group_rule" "payment-user" { 
 #  type              = "ingress"
  # security_group_id = data.aws_ssm_parameter.user-sg_id.value     
   #source_security_group_id =   data.aws_ssm_parameter.payment-sg_id.value    
   #from_port         = 8080
  # protocol          = "tcp"
   #to_port           = 8080
#}

resource "aws_security_group_rule" "payment-backend_alb" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.backend-ALB-sg_id.value     
   source_security_group_id =   data.aws_ssm_parameter.payment-sg_id.value    
   from_port         = 80
   protocol          = "tcp"
   to_port           = 80
}

#resource "aws_security_group_rule" "payment-cart" { 
 #  type              = "ingress"
  # security_group_id = data.aws_ssm_parameter.cart-sg_id.value     
 # source_security_group_id =   data.aws_ssm_parameter.payment-sg_id.value    
  # from_port         = 8080
  # protocol          = "tcp"
  # to_port           = 8080
#}





# backend_alb should traffic from frontend

resource "aws_security_group_rule" "frontend-backend_alb" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.backend-ALB-sg_id.value     #catalogue is accept 
   source_security_group_id = data.aws_ssm_parameter.frontend-sg_id.value    # cart connects to catalogue 
   from_port         = 80
   protocol          = "tcp"
   to_port           = 80
}

resource "aws_security_group_rule" "frontend-lb-frontend" { 
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.frontend-sg_id.value     #catalogue is accept 
   source_security_group_id = data.aws_ssm_parameter.frontend-lb-sg_id.value    # cart connects to catalogue 
   from_port         = 80
   protocol          = "tcp"
   to_port           = 80
}



#frontend alb accepting traffic from laptop
resource "aws_security_group_rule" "frontens-alb-laptop" {
   type              = "ingress"
   security_group_id = data.aws_ssm_parameter.frontend-lb-sg_id.value
   cidr_blocks = ["0.0.0.0/0"] #from internet
   from_port         = 443
   protocol          = "tcp"
   to_port           = 443
}