resource "aws_instance" "bastion_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.public_subnet_ids # we are creating bastion in public subnet
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id.value]
  tags = {
    Name = "roboshop"
    Environment = "dev"
    ec2 = "bastion"


  }
}