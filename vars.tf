variable "region" {
    default = "us-east-2"
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"  
}
variable "subnet_cidr-pub" {
    type = list
    default = ["10.0.1.0/24","10.0.2.0/24"] 
}
variable "azs" {
   default = ["us-east-2a","us-east-2b"]
}
variable "webserver_ami"{
    default = "ami-002068ed284fb165b"  
}
variable "webserver_type"{
     default = "t2.micro"     
}
variable "key"{
     default = "ANS"     
}