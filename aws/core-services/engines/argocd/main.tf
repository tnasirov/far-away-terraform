resource "helm_release" "argocd" {
  namespace        = var.namespace
  name             = "argocd"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  create_namespace = var.create_namespace
  version          = var.argocd_chart_version
  recreate_pods    = var.recreate_pods
  timeout          = var.timeout
  wait             = true

  values = [
    local.argocd_values
  ]

  dynamic "set" {
    for_each = var.extra_values
    content {
      name  = set.key
      value = set.value
    }
  }

  lifecycle {
    precondition {
      condition     = fileexists(local.values_yaml_path)
      error_message = " --> Error: Failed to find '${local.values_yaml_path}'. Exit terraform process."
    }
  }
}

resource "kubectl_manifest" "main_project" {
  yaml_body = local.app_project_yaml

  depends_on = [
    helm_release.argocd
  ]

  lifecycle {
    precondition {
      condition     = fileexists(local.app_project_yaml_path)
      error_message = " --> Error: Failed to find '${local.app_project_yaml_path}'. Exit terraform process."
    }
  }
}


resource "kubectl_manifest" "main_app" {
  for_each = toset(var.main_apps)
  yaml_body = templatefile(local.app_main_yaml_path, {
    namespace = each.value
  })
}

resource "kubectl_manifest" "argo-workflows-sso" {
  yaml_body = local.argo_workflows_sso_yaml

  lifecycle {
    precondition {
      condition     = fileexists(local.argo_workflows_sso_yaml_path)
      error_message = " --> Error: Failed to find '${local.argo_workflows_sso_yaml_path}'. Exit terraform process."
    }
  }
}