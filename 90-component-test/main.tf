module. "component" {
    source = "../terraform-roboshop-component"
    comonent_name = var.comonent
    ami_id = data.aws_ami.joindevops.id
    rule_priority = var.rule_priority


}