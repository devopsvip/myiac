resource "vault_kv_secret_v2" "secret" {
  mount               = vault_mount.kv-v2.path
  name                = "jenkins-login-secret"
  cas                 = 1
  delete_all_versions = false
  data_json = jsonencode(
    {
      username = "admin",
      password = "admin"
    }
  )
}

# Create jenkins policy in the root namespace
resource "vault_policy" "jenkins_policy" {
  name   = "jenkins"
  policy = file("policies/jenkins-policy.hcl")
}

resource "vault_approle_auth_backend_role" "jenkins-app-role" {
  role_name      = "jenkins-role"
  token_policies = ["jenkins"]
}

output "jenkins-role-id" {
  value = vault_approle_auth_backend_role.jenkins-app-role.role_id
}

resource "vault_approle_auth_backend_role_secret_id" "jenkinssecret_id" {
  role_name = vault_approle_auth_backend_role.jenkins-app-role.role_name
}

