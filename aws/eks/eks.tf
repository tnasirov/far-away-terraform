module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.11.1"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernets_version

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = false

  cluster_enabled_log_types = []

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  enable_irsa = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
    }
  }

  access_entries = local.merged_access_entries

  eks_managed_node_group_defaults = {
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }

    taints = {
      # This Taint aims to keep just EKS Addons and Karpenter running on this MNG
      # The pods that do not tolerate this taint should run on nodes created by Karpenter
      addons = {
        key    = "CriticalAddonsOnly"
        value  = "true"
        effect = "NO_SCHEDULE"
      },
    }
  }

  eks_managed_node_groups = var.eks_managed_node_groups

  node_security_group_additional_rules = local.node_security_group_additional_rules
  node_security_group_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }
  tags = merge(var.tags, {
    TerraformPath   = "far-away-terraform/aws/eks"
  })
}
