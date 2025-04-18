
module "vpc" {
  source = "../../modules/VPC"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  pub_subnet_cidr = var.pub_subnet_cidr
  priv_subnet_cidr = var.priv_subnet_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  pub_subnet_az = var.pub_subnet_az
  priv_subnet_az = var.priv_subnet_az
  igw_name = var.igw_name
  pub_subnet_name = var.pub_subnet_name
  priv_subnet_name = var.priv_subnet_name
  cluster_name = var.cluster_name
}

module "bastion_security" {
  source = "../../modules/Security"
  vpc_id = module.vpc.vpc_id
  name = var.bastion_sg_name
  description = var.bastion_sg_description
  ingress_from_port = var.bastion_sg_from_port
  ingress_to_port = var.bastion_sg_to_port
  ingress_protocol = var.bastion_sg_protocol
  ingress_cidr_blocks = var.bastion_sg_cidr_blocks
}

module "bastion" {
  source = "../../modules/Bastion"
  ami = var.bastion_ami
  instance_type = var.bastion_instance_type
  key_name = var.bastion_key_name
  subnet_id = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids = [module.bastion_security.security_group_id]
  depends_on = [module.vpc]
}

module "eks_security" {
  source = "../../modules/Security"
  vpc_id = module.vpc.vpc_id
  name = var.eks_sg_name
  description = var.eks_sg_description
  ingress_from_port = var.eks_sg_from_port
  ingress_to_port = var.eks_sg_to_port
  ingress_protocol = var.eks_sg_protocol
  ingress_cidr_blocks = var.eks_sg_cidr_blocks
  
}

module "eks" {
  source = "../../modules/EKS"
  cluster_version = var.eks_cluster_version
  vpc_id = module.vpc.vpc_id
  cluster_name = var.eks_cluster_name
  subnet_id = module.vpc.private_subnet_ids
  node_groups = var.eks_node_groups
  depends_on = [module.vpc]
  security_group_id = module.eks_security.security_group_id
}

module "s3" {
  source = "../../modules/S3"
  bucket_name = var.s3_bucket_name
  tags = var.s3_tags
}

module "dynamodb" {
  source = "../../modules/Dynamodb"
  table_name = var.dynamodb_table_name
  billing_mode = var.dynamodb_billing_mode
  hash_key = var.dynamodb_hash_key
  attribute_name = var.dynamodb_attribute_name
  attribute_type = var.dynamodb_attribute_type
}

  
