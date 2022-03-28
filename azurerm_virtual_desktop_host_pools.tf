#Create Windows Virtual Desktop elements
resource "time_rotating" "avd_token" {
  rotation_days = 30
}

resource "azurerm_virtual_desktop_host_pool" "demolab-hp1" {
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg1.name

  name                     = "demolab-hp1"
  friendly_name            = "demolab-hp1"
  validate_environment     = false
  description              = "Acceptance Test: A pooled host pool - pooleddepthfirst"
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "DepthFirst"

  registration_info {
    expiration_date = time_rotating.avd_token.rotation_rfc3339
  }
}
