provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_iam_ldap_policy" "ldap1" {
  name                   = "ldap_policy_1"
  description            = "test policy"
  enabled                = true
  enable_dns             = true
  user_search_precedence = "LocalUserDb"
 
  base_properties {
    attribute                  = "CiscoAvPair"
    base_dn                     = "DC=new,DC=com"
    bind_method                = "Anonymous"
    domain                     = "new.com"
    enable_encryption          = true
    enable_group_authorization = true
    filter                     = "sAMAccountName"
    group_attribute            = "memberOf"
    nested_group_search_depth  = 120
    timeout                    = 180
    object_type                = "iam.LdapBaseProperties"
  }
  dns_parameters {
    nr_source     = "Extracted"
    search_forest = "xyz"
    search_domain = "abc"
    object_type   = "iam.LdapDnsParameters"
  }
  
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

data "intersight_iam_end_point_role" "imc_admin" {
  name = "admin"
}

resource "intersight_iam_ldap_provider" "iam_ldap_provider1" {
  port   = 389
  server = "ldap.xyz.com"
  ldap_policy {
    moid        = intersight_iam_ldap_policy.ldap1.moid
    object_type = "iam.LdapPolicy"
  }
}

resource "intersight_iam_ldap_group" "iam_ldap_group1" {
  domain = "xyz.com"
  name   = "ldap_group"
  end_point_role {
    moid        = data.intersight_iam_end_point_role.imc_admin.results[0].moid
    object_type = "iam.EndPointRole"
  }
  ldap_policy {
    moid        = intersight_iam_ldap_policy.ldap1.moid
    object_type = "iam.LdapPolicy"
  }
}