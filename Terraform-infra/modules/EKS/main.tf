resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
  version = var.cluster_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_id
    security_group_ids     = [var.security_group_id]

  }
  tags = {
    "alpha.eksctl.io/cluster-oidc-enabled" = "true"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy_attachment]
} 

resource "aws_iam_role" "eks_node_role" {
  name = "${var.cluster_name}-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ])
  role = aws_iam_role.eks_node_role.name
  policy_arn = each.value

}

resource "aws_eks_node_group" "eks_node_group" {
  for_each = var.node_groups
  node_group_name = each.key
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_role_arn = aws_iam_role.eks_node_role.arn
  subnet_ids = var.subnet_id
  instance_types = each.value.instance_types
  capacity_type = each.value.capacity_type
  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    min_size = each.value.scaling_config.min_size
    max_size = each.value.scaling_config.max_size
  }
  depends_on = [aws_iam_role_policy_attachment.eks_node_policy_attachment]
  
}

