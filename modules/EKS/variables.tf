variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}


variable "cluster_version" {
  description = "The version of Kubernetes to use for the EKS cluster"
  type        = string
}
variable "vpc_id" {
  description = "The VPC ID to use for the EKS cluster"
  type        = string
}








variable "subnet_id" {
  description = "The subnet IDs to use for the EKS cluster"
  type        = list(string)
}

variable "node_groups" {
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












