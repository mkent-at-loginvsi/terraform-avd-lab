#Create NIC and associate the Public IP
resource "azurerm_network_interface" "region1-dc01-nic" {
  name                = "region1-dc01-nic"
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg1.name
  ip_configuration {
    name                          = "region1-dc01-ipconfig"
    subnet_id                     = azurerm_subnet.region1-vnet1-snet1.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.10.1.4"
	  public_ip_address_id = azurerm_public_ip.region1-dc01-pip.id
  }

   tags     = {
       Environment  = var.environment_tag
   }
}
#Create NIC
resource "azurerm_network_interface" "region1-avdsh01-nic" {
  name                = "region1-avdsh01-nic"
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg1.name
  ip_configuration {
    name                          = "region1-avdsh01-ipconfig"
    subnet_id                     = azurerm_subnet.region1-vnet1-snet1.id
    private_ip_address_allocation = "dynamic"
    #private_ip_address = "10.10.1.4"
	  #public_ip_address_id = azurerm_public_ip.region1-dc01-pip.id
  }

   tags     = {
       Environment  = var.environment_tag
   }
   depends_on = [
     azurerm_network_interface.region1-dc01-nic
   ]
}
