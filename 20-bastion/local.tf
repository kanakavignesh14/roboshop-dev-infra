locals {
    ami_id = data.aws_ami.joindevops.id
    #bastion_sg_id = data.aws_ssm_parameter.bastion-sg_id.value
    public_subnet_ids = split("," , data.aws_ssm_parameter.public_subnet_ids.value)[0] # like this public_subnet_ids = "10.0.1.0/24"

    
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = "true"
    }
}