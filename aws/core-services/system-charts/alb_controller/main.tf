module "alb_controller_irsa_role" {
  source                                 = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                                = "5.30.1"
  create_role                            = var.create_role_enabled
  role_name_prefix                       = var.serviceaccount
  attach_load_balancer_controller_policy = true
  attach_load_balancer_controller_targetgroup_binding_only_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = var.cluster_oidc_provider
      namespace_service_accounts = ["${var.namespace}:${var.serviceaccount}"]
    }
  }

  tags = merge(var.tags, {
    TerraformPath   = "far-away-terraform/aws/core-services/system-charts/alb_controller"
  })
}

resource "helm_release" "alb_controller" {
  name             = var.name
  chart            = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  create_namespace = var.namespace == "kube-system" ? false : true
  version          = var.alb_chart_version
  namespace        = var.namespace
  values           = [local.base_values]
}