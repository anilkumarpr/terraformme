terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.93.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "b53e1aac-f9ef-4aa5-9105-eb8fd0e5377e"
  client_id       = "c8396e6e-d814-4ea0-bf09-eee2297d6921"
  client_secret   = "M0w8Q~4_xpcd3eiuJQRMbaWgk6p8viM4Bk9rNbbM"
  tenant_id       = "01b1a9b2-d7ca-4cbf-b1c0-74d670679bfa"
  features {}
}
