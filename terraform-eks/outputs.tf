#---root/outputs.tf---

  output "cluster_name" {
    value = module.eks.cluster_id
  }

  output "ip_address" {
    value = module.eks.cluster_oidc_issuer_url
  }