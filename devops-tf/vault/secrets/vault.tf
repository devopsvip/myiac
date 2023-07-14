terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.11.0"
    }
  }
}

provider "vault" {
  # Configuration options
  address = "http://vault.idevops.site"
  token   = "root"
}


# Enable K/V v2 secrets engine at 'kv-v2'
resource "vault_mount" "kv-v2" {
  path = "devops/secrets"
  type = "kv-v2"
}

