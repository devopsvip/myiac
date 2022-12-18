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
  path = "kv-v2"
  type = "kv-v2"
}

resource "vault_kv_secret_v2" "secret" {
  mount               = vault_mount.kv-v2.path
  name                = "secret"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      zip = "zap",
      foo = "bar"
    }
  )
}


# Create admin policy in the root namespace
resource "vault_policy" "jenkins_policy" {
  name   = "jenkins"
  policy = file("policies/jenkins-policy.hcl")
}
