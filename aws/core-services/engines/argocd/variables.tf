# General

variable "argocd_chart_version" {
  type        = string
  description = "Version of the chart to install"
  default     = "7.0.0"
}

variable "namespace" {
  type        = string
  description = "Namespace to install the chart into"
}

variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name to install the chart into"
  default     = "argocd"
}

variable "extra_values" {
  type        = map(any)
  description = "Extra values in key value format"
  default     = {}
}

variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it does not exist"
  default     = true
}

variable "recreate_pods" {
  type        = bool
  description = "Recreate pods in the deployment if necessary"
  default     = true
}

variable "timeout" {
  type        = number
  description = "Timeout for the helm release"
  default     = 3000
}

variable sso_enabled {
  type        = bool
  default     = false
  description = "Single sign-on (SSO) authentication for argo-workflows"
}

variable "argocd_hostname" {
  type        = string
  description = "Hostname of argocd"
}

variable "main_apps" {
  type = list(string)
  description = "Main argocd app for Applications"
  default = []
}
