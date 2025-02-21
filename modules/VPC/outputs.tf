output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.open-tel-vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.open-tel-pub-subnet[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.open-tel-priv-subnet[*].id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.open-tel-vpc.cidr_block
}

output "nat_gateway_ip" {
  description = "The public IP address of the NAT Gateway"
  value       = aws_nat_gateway.open-tel-nat.public_ip
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.open-tel-pub-rt.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.open-tel-priv-rt.id
}