resource "aws_lb" "frontend_alb" {
  name               = "${local.common_name_suffix}-frontend-ALB" # roboshop-dev-backend-alb
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend-ALB-sg_id]
  # it should be private subnet ids
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false # prevents accidental deletion from UI

  tags = merge (
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-backend-alb"
    }
  )
}

# frontend ALB listening on port number 80       "default listener" we give catatlogue listener (realated traffic roututing) in catalogue 
resource "aws_lb_listener" "frontend_alb_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn # giving load balancer arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-3-2021-06"
  certificate_arn   = local.frontend_alb_certificate_arn   # we will attach our certificate arn to here to ssl validation and termiantion  

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hi, I am from HTTPS frontend ALB</h1>"
      status_code  = "200"
    }
  }
}


# Till here load balancer will be created  and we added listener wit default post and http and defalut action, now it have  default dns name without our domain name like
# roboshop-frontend-alb-123456.ap-south-1.elb.amazonaws.com ---> this is default dns, created for our LB now we are adding CNAME in route 53 like roboshop-dev.vigi-devops.com so it point to this dns created by aws to my frontend alb
# so finally request reaches my frontend LB. Now certificate validation taken place by because I added my validated certifate to my frontend LB. now public key will be downloaded to along certificate now tht browser validated tht certicate by their existing CA it have. 
#now it have session key encrypts with public key and semnd back to LB and LB decrypts it private key and now they have session key and request flows on  


resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "roboshop-${var.environment}.${var.domain_name}" # roboshop-dev.vigi-devops.fun
  type    = "A"
  allow_overwrite = true

  alias {
    # These are ALB details, not our domain details
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true
  }
}