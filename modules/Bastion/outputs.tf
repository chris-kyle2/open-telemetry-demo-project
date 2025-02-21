output "bastion_host_id" {
  description = "The ID of the bastion host"
  value       = aws_instance.bastion.id
}


output "bastion_host_public_ip" {
  description = "The public IP address of the bastion host"
  value       = aws_instance.bastion.public_ip
}


output "bastion_host_private_ip" {
  description = "The private IP address of the bastion host"
  value       = aws_instance.bastion.private_ip
}


output "bastion_host_security_group_id" {
  description = "The ID of the security group attached to the bastion host"
  value       = aws_instance.bastion.vpc_security_group_ids
}
output "subnet_id" {
  description = "The ID of the subnet the bastion host is in"
  value       = aws_instance.bastion.subnet_id
}


