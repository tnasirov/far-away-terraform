variable "name" {
  type        = string
  description = "Name of release"
  default     = "karpenter"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "karpenter"
}

variable "karpenter_chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = ""
}

variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "karpenter"
}
variable "wait" {
  type        = bool
  description = "Wait for successfull helm release"
  default     = false
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

variable "cluster_endpoint" {
  type        = string
  description = "EKS cluster OIDC provider ARN"
}

variable "tags" {
  type    = map(string)
  default = {}
}

