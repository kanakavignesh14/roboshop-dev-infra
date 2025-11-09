resource "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"
    type = "String"
    value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join("," , module.vpc.public_subnet_ids) # or for geting one public subnet idmodule.vpc.public_subnet_ids[0] it will recive output from vpc output module 
}

#["10.0.1.0/24", "10.0.2.0/24"]
# we are converting list to String using join
# "10.0.1.0/24,10.0.2.0/24"

# again to split 
#split(",", data.aws_ssm_parameter.public_subnet_ids.value)
# "10.0.1.0/24,10.0.2.0/24"
#["10.0.1.0/24", "10.0.2.0/24"]



resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join("," , module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  value = join("," , module.vpc.database_subnet_ids)
}
#Outputs: in output we recive like this so we getting public subnet of 1a zone 

#database_subnet_ids = [
  #"subnet-0d2ebad01f4cc4f79",
  #"subnet-0c639c934133afb32",
#]
#private_subnet_ids = [
 # "subnet-03040acb3f6a13e20",
  #"subnet-0592636217b9eabd2",
#]
#public_subnet_ids = [
 # "subnet-052dc5eaa4673f0fc",
  #"subnet-0f7ddc1d4ec15211b",
#]