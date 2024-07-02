terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.110.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}