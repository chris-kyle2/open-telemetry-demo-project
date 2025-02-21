variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames"
  type        = bool
}
variable "enable_dns_support" {
  description = "Whether to enable DNS support"
  type        = bool
}

variable "pub_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
}
variable "priv_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}
variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string
}     
variable "pub_subnet_name" {
  description = "The name of the public subnet"
  type        = list(string)
}
variable "priv_subnet_name" {
  description = "The name of the private subnet"
  type        = list(string)
}
variable "pub_subnet_az" {
  description = "The availability zone for the public subnet"
  type        = list(string)
}
variable "priv_subnet_az" {
  description = "The availability zone for the private subnet"
  type        = list(string)  
}

