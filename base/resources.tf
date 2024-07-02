resource "azurerm_resource_group" "dvp_statefile" {
  name     = "dvp-statefile"
  location = "Canada Central"
}

resource "azurerm_storage_account" "dvp_statefile" {
  name                     = "mccrackenyycdvpstatefile"
  resource_group_name      = azurerm_resource_group.dvp_statefile.name
  location                 = azurerm_resource_group.dvp_statefile.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    project = "DevOps POC"
  }
}

resource "azurerm_storage_container" "dvp_terraform" {
  name                  = "terraform"
  storage_account_name  = azurerm_storage_account.dvp_statefile.name
  container_access_type = "private"
}