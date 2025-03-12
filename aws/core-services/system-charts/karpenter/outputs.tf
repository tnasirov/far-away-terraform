output "id" {
  value = one(helm_release.karpenter[*].id)
}
