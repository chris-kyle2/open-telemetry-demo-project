variable "ami" {
  description = "The AMI to use for the bastion host"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the bastion host"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the bastion host"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to use for the bastion host"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "The VPC security group IDs to use for the bastion host"
  type        = list(string)
}
