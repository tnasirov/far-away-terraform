variable "name" {
  type        = string
  description = "Name of release"
  default     = "external-dns"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "external_dns_chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "1.14.4"
}

variable "create_role_enabled" {
  type        = bool
  description = "Enable or not chart as a component"
  default     = true
}

variable "extra_values" {
  type        = map(any)
  description = "Extra values in key value format"
  default     = {}
}

variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "external-dns"
}

variable "region" {
  type        = string
  description = "AWS region where the ASG placed"
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "cluster_oidc_provider" {
  type        = string
  description = "EKS cluster OIDC provider ARN"
}

variable "domain_names" {
  type        = list(string)
  description = "Roure53 hosted zone names"

}

variable "tags" {
  type    = map(string)
  default = {}
}
