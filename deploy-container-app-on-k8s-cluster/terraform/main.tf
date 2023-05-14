resource "azurerm_resource_group" "containerizationRG" {
  name     = "SCA-cloud-school1"
  location = "East US"
  tags = {
    source = "Resource group created via terraform"
  }
}

resource "azurerm_container_registry" "myContainerRegistry" {
  name                = "container110523"
  resource_group_name = azurerm_resource_group.containerizationRG.name
  location            = azurerm_resource_group.containerizationRG.location
  sku                 = "Basic"

}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "my-k8s-cluster"
  location            = azurerm_resource_group.containerizationRG.location
  resource_group_name = azurerm_resource_group.containerizationRG.name
  dns_prefix          = "my-k8s-cluster-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    source = "Cluster"
  }
}

# resource "azurerm_role_assignment" "example" {
#   principal_id                     = azurerm_kubernetes_cluster.example.kubelet_identity[0].object_id
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.example.id
#   skip_service_principal_aad_check = true
# }