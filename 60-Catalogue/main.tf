resource "aws_instance" "catalogue_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.private_subnet_ids # we are creating mongodb in database subnet # reffering local.tf
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id.value]  #reffering data.tf
  tags = {
    Name = "catalogue-ec2"
    Environment = "dev"
    ec2 = "catalogue_ec2"


  }
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue_ec2.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue_ec2.private_ip
  }

  # terraform copies this file to catalogue server

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  
  #giving execute permission to tht bootstrap file
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        #"sudo sh /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
    ]
  }
}


#stop the instance
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue_ec2.id
  state = "stopped"
  depends_on = [terraform_data.catalogue]
}

#This Terraform block is creating an "NEW AMI" (Amazon Machine Image) from your running EC2 instance.(catalogue_ec2) which will have os level info and services running in it
resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue_ec2.id # we are creating new ami from base one
  depends_on = [aws_ec2_instance_state.catalogue]
  tags = {
    Name = "catalogue-ec2"
    Environment = "dev"
    ec2 = "catalogue_ec2"


  }
}



# launh templates helps Auto scaling group to create instances .
resource "aws_launch_template" "catalogue_launch_template" {
  name = "${local.common_name_suffix}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id   # we giving here new ami id

  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"

  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id.value]

  # when we run terraform apply again, a new version will be created with new AMI ID
  update_default_version = true

  # tags attached to the instance
  tag_specifications {
    resource_type = "instance"

    tags = {
    Name = "catalogue-"
   


  }
  }

  # tags attached to the volume created by instance
  tag_specifications {
    resource_type = "volume"

    tags = {
    Name = "catalogue-"
   


  }
  }

  # tags attached to the launch template
  tags = {
    Name = "catalogue-"
   


  }

}


resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name_suffix}-catalogue-ASG"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false
  #giving here launch template details to ASG
  launch_template {
    id      = aws_launch_template.catalogue_launch_template.id
    version = aws_launch_template.catalogue_launch_template.latest_version
  }
  #giving here details abiut which zone and subnet these ec2 need to create

  vpc_zone_identifier       = local.private_subnet_ids

  #After creating send to Target group

  target_group_arns = [aws_lb_target_group.catalogue_target_group_arn] #ASG need to send ec2's to this target group where it have list of ec2's

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50 # atleast 50% of the instances should be up and running
    }
    triggers = ["launch_template"]
  }
  
  

  timeouts {
    delete = "15m"
  }

}

#ASG Policy checks
#Average CPU of all EC2s in the Auto Scaling Group

#Suppose our ASG currently has 3 EC2s.
#Their CPU usages:

#ASG calculates:
#Average CPU = (60 + 80 + 85) / 3
#Average CPU = 75%

#Since our policy says:
#Target = 75%

#If CPU goes above 75%, ASG will add more EC2s
#If CPU goes below 75%, ASG will remove EC2s

resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name                   = "${local.common_name_suffix}-catalogue"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }
}



# Target group will have list all ec2's and appectping HTTP traffic at port 8080
resource "aws_lb_target_group" "catalogue_target_group" {
  name     = "${local.common_name_suffix}-catalogue_target_group"
  port     = 8080 # accept 
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value

    health_check {
    healthy_threshold = 2
    interval = 10
    matcher = "200-299"
    path = "/health"
    port = 8080
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 2
  }
}
#path = "/health" → ALB will call /health on each EC2

#port = 8080 → Health check also happens on port 8080

#matcher = "200-299" → Any HTTP status between 200–299 = healthy

#interval = 10 → Health check runs every 10 seconds

#timeout = 2 → If no response within 2 seconds → fail

#healthy_threshold = 2 → Needs 2 successful checks to be marked healthy

#unhealthy_threshold = 2 → 2 failures → marked unhealthy