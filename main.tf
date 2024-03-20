terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }

  required_version = ">= 1.5.7"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-wtf" {
  name     = "rg-with-terraform"
  location = "West Europe"
}