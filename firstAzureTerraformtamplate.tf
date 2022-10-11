terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true
  
}
# Create a Recource Group 
resource "azurerm_resource_group" "rg" {
  name     = "test1"
  location = "westeurope"
}
#create a Network Security Group 
resource "azurerm_network_security_group" "nsg" {
  name                = "LabNSG"
  location            = "westeurope"
  resource_group_name = "test1"
}
#Open RDP Port 
resource "azurerm_network_security_rule" "rdpport" {
  name                        = "RDP"
  priority                    = 3389
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "3389"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "test1"
  network_security_group_name = azurerm_network_security_group.nsg.name
}