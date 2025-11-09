variable "project_name" {
    default = "roboshop"

}

variable "environment" {
    default = "dev"
}

variable "sg_name" {
    default = [
        #databases"
        "mongodb", "redis", "mysql", "rabbitmq",
        #backend
        "catalogue","user","shipping","payment","cart",
        #frontend
        "frontend",
        #bastion'
        "bastion", 
        #frontend LB
        "frontend-lb",
        #backend ALB
        "backend-ALB"
        
        
        
        ]
} 