resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "demolab-ws1"
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg1.name

  friendly_name = "Demolab WVD Workspace"
  description   = "Demolab Windows Virtual Desktop Workspace"
}
