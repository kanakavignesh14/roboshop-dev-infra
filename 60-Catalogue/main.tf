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

#This Terraform block is creating an AMI (Amazon Machine Image) from your running EC2 instance.
resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue_ec2.id
  depends_on = [aws_ec2_instance_state.catalogue]
  tags = {
    Name = "catalogue-ec2"
    Environment = "dev"
    ec2 = "catalogue_ec2"


  }
}