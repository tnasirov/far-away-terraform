data "aws_caller_identity" "current" {}

data "secrets_manager" "argocd_repo_credentials" {
  name = "argocd/repo/credentials"
}

locals {
  argocd_repo_credentials = jsondecode(data.secrets_manager.argocd_repo_credentials.secret_string)
}
