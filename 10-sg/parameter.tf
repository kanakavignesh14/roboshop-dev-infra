resource "aws_ssm_parameter" "sg_id" {
    count = length(var.sg_name)
    name = "/${var.project_name}/${var.environment}/${var.sg_name[count.index]}-sg_id" #roboshop/dev/catalogue-sg_id
    type = "String"
    value = module.sg[count.index].sg_id
            
            #module.sg[0].sg_id
}
#sg_id = [
 # "sg-05da62382f28d0941",
  #"sg-0d3d368b1040fd64d",
  #"sg-0d4b69f5e3f21ce19",
#  "sg-041fca8e7f2a3f123",
 # "sg-045c3a1298b56ed3d",
  #"sg-0fad80f9f0a9b1583",
#  "sg-0287d18bfcb63823e",
 # "sg-0939579a9a75f89f5",
  #"sg-003553e74f785d499",
 # "sg-04f441855e9999f06",
  #"sg-031a854b621a458e0",
#]