module "component" {
    source = "../../terraform-roboshop-componet"
    component_name = var.component_name
    ami_id = data.aws_ami.joindevops.id
    rule_priority = var.rule_priority


}
