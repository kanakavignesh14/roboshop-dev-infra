#module "component" {
 #   source = "../../terraform-roboshop-componet"
  #  component_name = var.component_name
 #   ami_id = data.aws_ami.joindevops.id
  #  rule_priority = var.rule_priority


#}



module "components" {
    for_each = var.components
    source = "git::https://github.com/kanakavignesh14/terraform-roboshop-componet.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}