provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "azuread" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "example" {
  name     = "rg-terraworks"
  location = "West Europe"
}

resource "azuread_user" "p8" {
  user_principal_name = "p8@pemmrajusirishaoutlook.onmicrosoft.com"  # Replace with your tenant's verified domain
  display_name        = "P8 User"
  password            = var.admin_password
}

resource "azurerm_role_assignment" "example" {
  principal_id         = azuread_user.p8.object_id
  role_definition_name = "Contributor"
  scope                = "/subscriptions/${var.subscription_id}"
}
