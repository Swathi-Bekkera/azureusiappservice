resource "random_string" "string"{
    length = 5
    lower = true
    upper = false
    special = false
}

resource "azurerm_user_assigned_identity" "umi"{
    resource_group_name = azurerm_resource_group.fw.name
    location = azurerm_resource_group.fw.location
    name = umi-${random.string.string.id}
}

resource "azurerm_app_service_plan" "myappsp" {
    resource_group_name = azurerm_resource_group.fw.name
    location = azurerm_resource_group.fw.location
    sku = "B1"
    name = webapp-asp-${random_string.string.id}
}

resource "azurerm_app_service" "myapp" {
    resource_group_name = azurerm_resource_group.fw.name
    location = azurerm_resource_group.fw.location
    name = webapp-${random_String.string.id}
    app_service_plan_id = azurerm_app_service_plan.myappsp.id
    identity {
      type = "UserAssigned"
      identity_ids = azurerm_user_assigned_identity.umi.id
    }
}




