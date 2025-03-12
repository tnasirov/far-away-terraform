locals {
  values                 = "${path.module}/yamls/values.yaml"
  node_class_default     = "${path.module}/yamls/nodeclass-default.yaml"
  node_pool_default      = "${path.module}/yamls/nodepool-default.yaml"

  base_values = templatefile(local.values, {
    release_name         = var.name
    region               = var.region
    cluster_name         = var.cluster_name
    cluster_endpoint     = var.cluster_endpoint
    karpenter_queue_name = module.karpenter.queue_name
    irsa_role            = module.karpenter.iam_role_arn
  })

  node_class_default_rendered = templatefile(local.node_class_default, {
    role_name    = module.karpenter.node_iam_role_name
    cluster_name = var.cluster_name
  })
  
  node_pool_default_rendered = templatefile(local.node_pool_default, {
    azs = slice(data.aws_availability_zones.available.names, 0, 3)
  })

}