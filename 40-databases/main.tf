resource "aws_instance" "mongodb_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_ids # we are creating mongodb in database subnet # reffering local.tf
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id.value]  #reffering data.tf
  tags = {
    Name = "mongodb-ec2"
    Environment = "dev"
    ec2 = "mongodb_ec2"


  }
}

# when mongodb instace created with id means  it will trigger 
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb_ec2.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb_ec2.private_ip
  }

  # terraform copies this file to mongodb server
  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  
  #giving execute permission to tht bootstrap file
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        #"sudo sh /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb dev"
    ]
  }



}


resource "aws_instance" "redis_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_ids # we are creating redis in database subnet reffering local.tf
  vpc_security_group_ids = [data.aws_ssm_parameter.redis-sg_id.value]  # reffering data.tf for security_group_id
  tags = {
    Name = "redis-ec2"
    Environment = "dev"
    ec2 = "redis_ec2"


  }
}

# when redis instace created with id means  it will trigger 
resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis_ec2.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis_ec2.private_ip
  }

  # terraform copies this file to mongodb server
  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  
  #giving execute permission to tht bootstrap file
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh redis dev"
    ]
  }



}


resource "aws_instance" "rabbitmq_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_ids # we are creating redis in database subnet reffering local.tf
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq-sg_id.value]  # reffering data.tf for security_group_id
  tags = {
    Name = "rabbitmq-ec2"
    Environment = "dev"
    ec2 = "rabbitmq_ec2"


  }
}

# when redis instace created with id means  it will trigger 
resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq_ec2.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq_ec2.private_ip
  }

  # terraform copies this file to rabbitmq_ec2 server
  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  
  #giving execute permission to tht bootstrap file
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh rabbitmq dev"
    ]
  }



}

resource "aws_instance" "mysql_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_ids # we are creating redis in database subnet reffering local.tf
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql-sg_id.value]  # reffering data.tf for security_group_id
  tags = {
    Name = "mysql-ec2"
    Environment = "dev"
    ec2 = "mysql_ec2"


  }
}
resource "aws_iam_instance_profile" "mysql" {
  name = "mysql"
  role = "EC2SSMParameterRead"
}

# when redis instace created with id means  it will trigger when instance id created
resource "terraform_data" "mysql" { 
  triggers_replace = [
    aws_instance.mysql_ec2.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql_ec2.private_ip
  }

  # terraform copies this file to rabbitmq_ec2 server
  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  
  #giving execute permission to tht bootstrap file
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mysql dev"
    ]
  }



}

#for mysql instance
#terraform passing dev as args to shell
#shell recieved into varible $2 (environment=$2)
#shell passing to ansible which want environment in ansible-role main.yaml from there it will seek ssm parameter values for mysql server


resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb_ec2.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "redis-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis_ec2.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql_ec2.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "rabbitmq-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq_ec2.private_ip]
  allow_overwrite = true
}