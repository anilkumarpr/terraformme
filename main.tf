resource "azurerm_virtual_machine" "qas_web_disp" {
  count=length(var.web_disp_vm_names)
  name                = var.web_disp_vm_names[count.index]
  resource_group_name = local.resource_group
  location            = var.resource_location
  size                = "Standard_D2s_v3"
  admin_username      = "linuxusr"
  admin_password      = "Azure@123"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.qas_web_disp.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.qas_web_disp
  ]
}

resource "azurerm_network_interface" "qas_web_disp" {
    count= length(var.web_disp_vm_names)
    name = "nic-${var.web_disp_vm_names[count.index]}"
    location            = var.resource_location
    resource_group_name = local.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.sap_qas_app_snet.id
    private_ip_address_allocation = "Dynamic"
  }
  
}

data "azurerm_subnet" "sap_qas_app_snet" {
  name                 = "sap_qas_app_snet"
  resource_group_name  = local.resource_group
  virtual_network_name = "sap_qas_vnet"
}
