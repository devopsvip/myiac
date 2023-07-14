variable "argocd_manifests" {
  type        = string
  description = "argocd install file"
  default     = "argocd/v2.6.0"
}

variable "argoworkflow_manifests" {
  type        = string
  description = "argocd install file"
  default     = "argo-workflow/v3.4.5"
}
