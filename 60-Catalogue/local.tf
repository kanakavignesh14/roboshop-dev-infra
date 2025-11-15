locals{
    #subnet_id = data.aws_ssm_parameter.
    private_subnet_ids = split("," , data.aws_ssm_parameter.private_subnet_ids.value)
    ami_id = data.aws_ami.joindevops.id
    common_name_suffix ="${var.project_name}-${var.environment}" 
}