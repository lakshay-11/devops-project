variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"  
}

variable "public_subnets" {
  default = ["10.0.0.0/24" , "10.0.0.0/24"]  
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "jenkins"
}
