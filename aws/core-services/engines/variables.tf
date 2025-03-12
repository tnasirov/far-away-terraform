
#ArgoCD
variable "argocd_release_name" {
  type        = string
  description = "Name of release"
  default     = "argocd"
}
variable "argocd_enabled" {
  type    = bool
  default = false
}
variable "argocd_namespace" {
  type        = string
  description = "Namespace to install the chart into"
  default     = "argocd"
}

variable "argocd_hostname" {
  type        = string
  description = "Hostname of argocd"
}

variable "argocd_chart_version" {
  type        = string
  description = "Version of the chart to install"
  default     = "7.0.0"
}

variable "argocd_main_apps" {
  type = list(string)
  description = "Main argocd app for Applications"
  default = []
}

variable "argocd_sso_enabled" {
  type = bool
  description = "ArgoCD SSO"
  default = false
}

variable "argocd_admins_group_id" {
  type = string
  description = "Group ID of admins group from AWS"
}

variable "argocd_readonly_group_id" {
  type = string
  description = "Group ID of admins group from AWS"
}

variable "aws_sso_ca_data" {
  type = string
  description = "base64 encoded caData for ArgoCD - AWS SSO auth"
}

variable "aws_sso_url" {
  type = string
  description = "AWS SSO url for ArgoCD - AWS SSO"
}

variable "cluster_oidc_provider" {
  description = "The OIDC provider to use for the cluster"
  type        = string
  default     = "oidc.eks.region.amazonaws.com/id/cluster_name:sub"
}

variable "gitops_repo_url" {
  type = string
  description = "Gitops repo url"
}

variable "gitops_repo_username" {
  type = string
  description = "Gitops repo username"
}

variable "gitops_repo_password" {
  type = string
  description = "Gitops repo password"
}

variable "tags" {
  type    = map(string)
  default = {}
}
