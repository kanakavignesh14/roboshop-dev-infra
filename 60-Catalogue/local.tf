locals{
    #subnet_id = data.aws_ssm_parameter.
    private_subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0] # ["10.0.1.0/24"]
    private_subnet_ids = split("," , data.aws_ssm_parameter.private_subnet_ids.value)  # here we will get from ssmparameter list ["10.0.1.0/24","10.0.2.0/24"]
    ami_id = data.aws_ami.joindevops.id
    common_name_suffix ="${var.project_name}-${var.environment}" 
}