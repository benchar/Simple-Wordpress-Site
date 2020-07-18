variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_cidr_block" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.12.0/24"]
}

variable "private_cidr_block" {
  type    = list(string)
  default = ["10.0.14.0/24", "10.0.16.0/24"]
}

variable "subnet_count" {
  type = string
}

variable "tags" {
  type = string
}

variable "tags2" {
  type = string
}
