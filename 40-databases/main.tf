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
        "sudo sh /tmp/bootstrap.sh mongodb"
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
        "sudo sh /tmp/bootstrap.sh redis"
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
        "sudo sh /tmp/bootstrap.sh rabbitmq"
    ]
  }



}