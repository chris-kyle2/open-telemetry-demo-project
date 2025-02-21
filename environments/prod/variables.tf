
##### VPC Variables Configuration #####
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "pub_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
}
variable "priv_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}
variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames"
  type        = bool
}
variable "enable_dns_support" {
  description = "Whether to enable DNS support"
  type        = bool
}

variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string
}
variable "pub_subnet_az" {
  description = "The availability zone for the public subnet"
  type        = list(string)
}
variable "priv_subnet_az" {
  description = "The availability zone for the private subnet"
  type        = list(string)
}
variable "pub_subnet_name" {
  description = "The name of the public subnet"
  type        = list(string)
}
variable "priv_subnet_name" {
  description = "The name of the private subnet"
  type        = list(string)
}

##### BastionSecurity Variables Configuration #####
variable "bastion_sg_name" {
  description = "The name of the bastion security group"
  type        = string
}   
variable "bastion_sg_description" {
  description = "The description of the bastion security group"
  type        = string
}
variable "bastion_sg_type" {
  description = "The type of the bastion security group"
  type        = string
}
variable "bastion_sg_from_port" {
  description = "The from port of the bastion security group"
  type        = number
}
variable "bastion_sg_to_port" {
  description = "The to port of the bastion security group"
  type        = number
}
variable "bastion_sg_protocol" {
  description = "The protocol of the bastion security group"
  type        = string
}
variable "bastion_sg_cidr_blocks" {
  description = "The CIDR blocks to allow ingress from"
  type        = list(string)
}


##### Bastion Variables Configuration #####
variable "bastion_ami" {
  description = "The AMI to use for the bastion host"
  type        = string
}
variable "bastion_instance_type" {
  description = "The instance type to use for the bastion host"
  type        = string
}
variable "bastion_key_name" {
  description = "The key name to use for the bastion host"
  type        = string
}



##### EKS Security Variables Configuration #####
variable "eks_sg_name" {
  description = "The name of the EKS security group"
  type        = string
}
variable "eks_sg_description" {
  description = "The description of the EKS security group"
  type        = string
}
variable "eks_sg_type" {
  description = "The type of the EKS security group"
  type        = string
}
variable "eks_sg_from_port" {
  description = "The from port of the EKS security group"
  type        = number
}
variable "eks_sg_to_port" {
  description = "The to port of the EKS security group"
  type        = number
}
variable "eks_sg_protocol" {
  description = "The protocol of the EKS security group"
  type        = string
}   
variable "eks_sg_cidr_blocks" {
  description = "The CIDR blocks to allow ingress from"
  type        = list(string)
}



##### EKS Variables Configuration #####
variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}
variable "eks_cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "eks_node_groups" {
  description = "The node groups to create in the EKS cluster"
  type        = map(object({
    instance_types = list(string)
    capacity_type = string
    scaling_config = object({
      min_size = number
      max_size = number
      desired_size = number
    })
  }))
}















