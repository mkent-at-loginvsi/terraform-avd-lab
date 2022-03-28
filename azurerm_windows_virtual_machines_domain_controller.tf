#Create data disk for NTDS storage
resource "azurerm_managed_disk" "region1-dc01-data" {
  name                 = "region1-dc01-data"
  location             = var.loc1
  resource_group_name  = azurerm_resource_group.rg1.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "5"
  tags = {
    Environment  = var.environment_tag
  }
}
#Create Domain Controller VM
resource "azurerm_windows_virtual_machine" "region1-dc01-vm" {
  name                = "region1-dc01-vm"
  depends_on = [ azurerm_resource_group.rg1 ]
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.loc1
  size                = var.vmsize-domaincontroller
  admin_username      = var.adminusername
  admin_password      = var.adminpassword
  network_interface_ids = [
    azurerm_network_interface.region1-dc01-nic.id,
  ]
  tags = {
       Environment  = var.environment_tag
   }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
#Attach Data Disk to Virtual Machine
resource "azurerm_virtual_machine_data_disk_attachment" "region1-dc01-data" {
  managed_disk_id    = azurerm_managed_disk.region1-dc01-data.id
  depends_on = [ azurerm_windows_virtual_machine.region1-dc01-vm ]
  virtual_machine_id = azurerm_windows_virtual_machine.region1-dc01-vm.id
  lun                = "10"
  caching            = "None"
  }
#Run setup script on dc01-vm
resource "azurerm_virtual_machine_extension" "region1-dc01-basesetup" {
  name                 = "region1-dc01-basesetup"
  virtual_machine_id   = azurerm_windows_virtual_machine.region1-dc01-vm.id
  depends_on = [ azurerm_virtual_machine_data_disk_attachment.region1-dc01-data ]
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./baselab_DCSetup.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/mkent-at-loginvsi/terraform-avd-lab/main/Powershell/DCSetup.ps1"
        ]
    }
  SETTINGS
}
resource "azurerm_virtual_machine_extension" "region1-dc01-domainsetup" {
  name                 = "region1-dc01-domainsetup"
  virtual_machine_id   = azurerm_windows_virtual_machine.region1-dc01-vm.id
  depends_on = [ azurerm_virtual_machine_data_disk_attachment.region1-dc01-data ]
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./DomainSetup.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/mkent-at-loginvsi/terraform-avd-lab/main/Powershell/DomainSetup.ps1"
        ]
    }
  SETTINGS

}
