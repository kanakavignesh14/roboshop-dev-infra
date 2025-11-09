resource "aws_instance" "mongodb_ec2" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_ids # we are creating mongodb in database subnet # reffering local.tf
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id.value]  #reffering data.tf
  tags = {
    Name = "roboshop"
    Environment = "dev"
    ec2 = "mongodb_ec2"


  }
}

# when mongodb instace created with id means  it will trigger 
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }
  provisioner "remote-exec" {
    inline = [
        "heloo"
    ]
  }



}