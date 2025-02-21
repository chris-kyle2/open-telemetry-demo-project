variable "name" {
  description = "The name of the security group"
  type        = string
}
variable "ingress_from_port" {
  description = "The from port of the security group rule"
  type        = number
}

variable "ingress_to_port" {
  description = "The to port of the security group rule"
  type        = number
}

variable "ingress_protocol" {
  description = "The protocol of the security group rule"
  type        = string
}


variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "description" {
  description = "The description of the security group"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "The CIDR blocks to allow ingress from"
  type        = list(string)
}


