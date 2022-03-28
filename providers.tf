#Providers
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.49.0"
    }
    azuread = {
     source = "hashicorp/azuread"
    }
    random = {
      source = "hashicorp/random"
      version = "=3.1.0"
    }
  }
}
provider "azurerm" {
  # Configuration options
    features {
      #key_vault {
      #purge_soft_delete_on_destroy = true
      #}
  }
}
