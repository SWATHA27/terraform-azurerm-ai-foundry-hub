data "azurerm_key_vault" "example" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_ai_foundry" "ai_foundry" {
  name                    = var.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  key_vault_id            = data.azurerm_key_vault.example.id
  storage_account_id      = azurerm_storage_account.example.id

    depends_on = [azurerm_storage_account.example]

  identity {
    type = "SystemAssigned"
  }
}

# SA
# Creates a Storage account
resource "azurerm_storage_account" "example" {
  name                            = "${var.name}-stg"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  shared_access_key_enabled       = var.shared_access_key_enabled
  min_tls_version                 = var.min_tls_version
  access_tier                     = var.access_tier
  public_network_access_enabled   = var.public_network_access_enabled
  enable_https_traffic_only       = var.enable_https_traffic_only

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}