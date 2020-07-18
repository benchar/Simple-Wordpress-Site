variable "master_username" {
  default = "username"
}

variable "master_password" {
  default = "password"
}

variable "database_name" {
}

variable "engine" {
  default = "aurora-mysql"
}

variable "engine_version" {
  default = "5.7.mysql_aurora.2.03.2"
}

variable "vpc_id" {

}

variable "subnet_id" {

}

variable "ecs_security_group" {

}
