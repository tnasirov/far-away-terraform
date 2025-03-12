module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "~> 20.11"

  cluster_name                    = var.cluster_name
  create_pod_identity_association = false
  enable_irsa                     = true
  irsa_oidc_provider_arn          = var.cluster_oidc_provider
  irsa_namespace_service_accounts = ["${var.namespace}:${var.serviceaccount}"]

  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  create_instance_profile = true

  tags = merge(var.tags, {
    TerraformPath   = "far-away-terraform/aws/core-services/system-charts/karpenter"
  })
}

resource "helm_release" "karpenter" {
  ### If we dont wait, alb controller might not be ready which causes helm release to fail
  depends_on       = [module.karpenter]
  namespace        = var.namespace
  create_namespace = var.namespace == "kube-system" ? false : true
  version          = var.karpenter_chart_version
  name             = var.name
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  values           = [local.base_values]
  wait             = var.wait
}


### Default Nodeclass and Nodepool ###
resource "kubectl_manifest" "karpenter_node_class" {
  depends_on = [helm_release.karpenter]
  yaml_body  = local.node_class_default_rendered

  lifecycle {
    precondition {
      condition     = fileexists(local.node_class_default)
      error_message = " --> Error: Failed to find '${local.node_class_default}'. Exit terraform process."
    }
  }
}

resource "kubectl_manifest" "karpenter_node_pool" {
  depends_on = [helm_release.karpenter]
  yaml_body = local.node_pool_default_rendered
  lifecycle {
    precondition {
      condition     = fileexists(local.node_pool_default)
      error_message = " --> Error: Failed to find '${local.node_pool_default}'. Exit terraform process."
    }
  }
}

