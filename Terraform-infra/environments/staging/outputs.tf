output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}


output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}


output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}


output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}


output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.bucket_name
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = module.dynamodb.table_arn
}

output "eks_security_group_id" {
  description = "The ID of the EKS security group"
  value       = module.eks_security.security_group_id
}














