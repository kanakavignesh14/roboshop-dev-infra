resource "aws_instance" "bastion_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.public_subnet_ids # we are creating bastion in public subnet

  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id.value]
  iam_instance_profile = aws_iam_instance_profile.bastion_role.name # connecting iam role to ec2
  
# to increase disk size
  root_block_device {
        volume_size = 50
        volume_type = "gp3" # or "gp2", depending on your preference
    }

  user_data = file("bastion.sh")
  tags = {
    Name = "bastion-host-ec2"
    Environment = "dev"
    ec2 = "bastion"


  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo",
      "sudo yum -y install terraform"
    ]
  }

}
resource "aws_iam_instance_profile" "bastion_role" {
  name = "bastion"
  role = "BastionTerraformAdmin"
}



# write one remote_exec to install terraform

 