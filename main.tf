terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "resgroup" {
  name = "JLL-AM-RG-Corrigo-CSDev01"
  location = "Central US"
}


resource "azurerm_storage_account" "tonneytestsa" {
  name                     = "tonneysa"
  resource_group_name      = azurerm_resource_group.resgroup.name
  location                 = azurerm_resource_group.resgroup.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = var.replicationType

  tags = {
    environment = "test"
  }
}

resource "azurerm_storage_container" "containerres" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.tonneytestsa.name
  container_access_type = "private"
}