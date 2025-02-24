resource "aws_security_group" "security_group" {

  name = var.name
  description = var.description
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "security_group_ingress" {
  type              = "ingress"
  from_port         = var.ingress_from_port
  to_port           = var.ingress_to_port
  protocol          = var.ingress_protocol
  security_group_id = aws_security_group.security_group.id
  cidr_blocks       = var.ingress_cidr_blocks
}

resource "aws_security_group_rule" "security_group_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}