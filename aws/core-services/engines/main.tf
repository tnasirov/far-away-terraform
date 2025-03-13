
module "argocd" {
  count                      = var.argocd_enabled ? 1 : 0
  source                     = "./argocd"
  namespace                  = var.argocd_namespace
  argocd_hostname            = var.argocd_hostname
  argocd_chart_version       = var.argocd_chart_version
  main_apps                  = var.argocd_main_apps
  sso_enabled                = var.argocd_sso_enabled
}

