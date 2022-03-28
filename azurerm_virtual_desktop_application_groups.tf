# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = azurerm_resource_group.rg1.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.demolab-hp1.id
  location            = var.loc1
  type                = "Desktop"
  name                = "demolab-ag1"
  friendly_name       = "Desktop AppGroup"
  description         = "AVD application group"
  depends_on          = [azurerm_virtual_desktop_host_pool.demolab-hp1, azurerm_virtual_desktop_workspace.workspace]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}
