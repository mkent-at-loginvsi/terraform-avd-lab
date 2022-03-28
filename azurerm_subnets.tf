resource "azurerm_subnet" "region1-vnet1-snet1" {
  name                 = var.region1-vnet1-snet1-name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet1-hub1.name
  address_prefixes     = [var.region1-vnet1-snet1-range]
}
