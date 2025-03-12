locals {  
  values_yaml_path             = "${path.module}/yamls/values.yaml"
  app_project_yaml_path        = "${path.module}/yamls/app-project.yaml"
  app_main_yaml_path           = "${path.module}/yamls/app-main.yaml"
  argo_workflows_sso_yaml_path = "${path.module}/yamls/argo-sso-secret.yaml"
  
  argocd_values = templatefile(local.values_yaml_path, {
    hostname                   = var.argocd_hostname
    gitops_repo_url            = var.gitops_repo_url
    gitops_repo_password       = var.gitops_repo_password
    gitops_repo_username       = var.gitops_repo_username
    sso_enabled                = var.sso_enabled
  })

  app_project_yaml = templatefile(local.app_project_yaml_path, {
  })
}

