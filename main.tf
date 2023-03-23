//bringing existing resource group sap_nprd
data azurerm_resource_group "sap_nprd"{
    name= "sap_nprd"
}

//existing app snet
data azurerm_subnet "sap_qas_app_snet" {
  name                 = "sap_qas_app_snet"
  resource_group_name  = data.azurerm_resource_group.sap_nprd.name
  virtual_network_name = "sap_qas_vnet"
}

//existing db snet
data azurerm_subnet "sap_qas_db_snet" {
  name                 = "sap_qas_db_snet"
  resource_group_name  = data.azurerm_resource_group.sap_nprd.name
  virtual_network_name = "sap_qas_vnet"
}

//qas web dispatcher vms
resource "azurerm_virtual_machine" "qas_web_disp" {
  count=length(var.web_disp_vm_names)
  name                = var.web_disp_vm_names[count.index]
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  availability_set_id = azurerm_availability_set.qas_web_disp_set.id
  network_interface_ids = [
    azurerm_network_interface.qas_web_disp[count.index].id,
  ]
  vm_size             = "Standard_D2s_v3"
   storage_os_disk {
        name              = "${var.web_disp_vm_names[count.index]}-osdisk"
        caching           = "ReadWrite"
        create_option     = "Empty"
        managed_disk_type = "Premium_LRS"
        disk_size_gb      = "100"
      }
      os_profile {
        computer_name  = var.web_disp_vm_names[count.index]
        admin_username = "testadmin"
        admin_password = "Password1234!"
      }
      os_profile_linux_config {
        disable_password_authentication = false
      }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.qas_web_disp,
    azurerm_availability_set.qas_web_disp_set
  ]
}

resource "azurerm_network_interface" "qas_web_disp" {
    count= length(var.web_disp_vm_names)
    name = "nic-${var.web_disp_vm_names[count.index]}"
    location            = var.resource_location
    resource_group_name = data.azurerm_resource_group.sap_nprd.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.sap_qas_app_snet.id
    private_ip_address_allocation = "Dynamic"
  }
  
}
resource "azurerm_availability_set" "qas_web_disp_set" {
  name                = "qas_web_disp_set"
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  platform_fault_domain_count = 3
  platform_update_domain_count = 3  
}

//qas ascs vms
resource "azurerm_virtual_machine" "qas_ascs" {
  count=length(var.qas_ascs_vm_names)
  name                = var.qas_ascs_vm_names[count.index]
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  availability_set_id = azurerm_availability_set.qas_ascs_set.id
  network_interface_ids = [
    azurerm_network_interface.qas_ascs[count.index].id,
  ]
  vm_size             = "Standard_D2s_v3"
   storage_os_disk {
        name              = "${var.qas_ascs_vm_names[count.index]}-osdisk"
        caching           = "ReadWrite"
        create_option     = "Empty"
        managed_disk_type = "Premium_LRS"
        disk_size_gb      = "100"
      }
      os_profile {
        computer_name  = var.qas_ascs_vm_names[count.index]
        admin_username = "testadmin"
        admin_password = "Password1234!"
      }
      os_profile_linux_config {
        disable_password_authentication = false
      }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.qas_ascs,
    azurerm_availability_set.qas_ascs_set
  ]
}

resource "azurerm_network_interface" "qas_ascs" {
    count= length(var.qas_ascs_vm_names)
    name = "nic-${var.qas_ascs_vm_names[count.index]}"
    location            = var.resource_location
    resource_group_name = data.azurerm_resource_group.sap_nprd.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.sap_qas_app_snet.id
    private_ip_address_allocation = "Dynamic"
  }
  
}
resource "azurerm_availability_set" "qas_ascs_set" {
  name                = "qas_ascs_set"
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  platform_fault_domain_count = 3
  platform_update_domain_count = 3  
}


//qas app vms
resource "azurerm_virtual_machine" "qas_app" {
  count=length(var.qas_app_vm_names)
  name                = var.qas_app_vm_names[count.index]
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  availability_set_id = azurerm_availability_set.qas_app_set.id
  network_interface_ids = [
    azurerm_network_interface.qas_app[count.index].id,
  ]
  vm_size             = "Standard_D2s_v3"
   storage_os_disk {
        name              = "${var.qas_app_vm_names[count.index]}-osdisk"
        caching           = "ReadWrite"
        create_option     = "Empty"
        managed_disk_type = "Premium_LRS"
        disk_size_gb      = "100"
      }
      os_profile {
        computer_name  = var.qas_app_vm_names[count.index]
        admin_username = "testadmin"
        admin_password = "Password1234!"
      }
      os_profile_linux_config {
        disable_password_authentication = false
      }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.qas_app,
    azurerm_availability_set.qas_app_set
  ]
}

resource "azurerm_network_interface" "qas_app" {
    count= length(var.qas_app_vm_names)
    name = "nic-${var.qas_app_vm_names[count.index]}"
    location            = var.resource_location
    resource_group_name = data.azurerm_resource_group.sap_nprd.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.sap_qas_app_snet.id
    private_ip_address_allocation = "Dynamic"
  }
  
}
resource "azurerm_availability_set" "qas_app_set" {
  name                = "qas_app_set"
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  platform_fault_domain_count = 3
  platform_update_domain_count = 3  
}


//qas db vms
resource "azurerm_virtual_machine" "qas_db" {
  count=length(var.qas_db_vm_names)
  name                = var.qas_db_vm_names[count.index]
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  availability_set_id = azurerm_availability_set.qas_db_set.id
  network_interface_ids = [
    azurerm_network_interface.qas_db[count.index].id,
  ]
  vm_size             = "Standard_D2s_v3"
   storage_os_disk {
        name              = "${var.qas_db_vm_names[count.index]}-osdisk"
        caching           = "ReadWrite"
        create_option     = "Empty"
        managed_disk_type = "Premium_LRS"
        disk_size_gb      = "100"
      }
      os_profile {
        computer_name  = var.qas_db_vm_names[count.index]
        admin_username = "testadmin"
        admin_password = "Password1234!"
      }
      os_profile_linux_config {
        disable_password_authentication = false
      }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.qas_db,
    azurerm_availability_set.qas_db_set
  ]
}

resource "azurerm_network_interface" "qas_db" {
    count= length(var.qas_db_vm_names)
    name = "nic-${var.qas_db_vm_names[count.index]}"
    location            = var.resource_location
    resource_group_name = data.azurerm_resource_group.sap_nprd.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.sap_qas_db_snet.id
    private_ip_address_allocation = "Dynamic"
  }
  
}
resource "azurerm_availability_set" "qas_db_set" {
  name                = "qas_db_set"
  location            = var.resource_location
  resource_group_name = data.azurerm_resource_group.sap_nprd.name
  platform_fault_domain_count = 3
  platform_update_domain_count = 3  
}


