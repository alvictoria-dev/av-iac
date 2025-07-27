# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location = var.var_LOCNAME
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                  = var.var_NAMEAKS
  location              = var.var_LOCNAME
  resource_group_name   = var.var_RGAKSNAME
  kubernetes_version    = data.azurerm_kubernetes_service_versions.current.latest_version
  dns_prefix            = "${var.var_NAMEAKS}-dns" 
  role_based_access_control_enabled = true

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_B2ms"
    node_count = 1
    max_pods   = 110
    vnet_subnet_id = var.var_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_plugin_mode = "overlay"
    load_balancer_sku = "standard"
    pod_cidr = "10.224.0.0/16"
  }

  workload_autoscaler_profile {
    keda_enabled                    = true
    vertical_pod_autoscaler_enabled = true
  }

  lifecycle {
    ignore_changes = [ 
      default_node_pool[0].upgrade_settings
     ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "aks-cluster-nodepool" {
    kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-cluster.id
    name       = "apppool"
    vm_size    = "Standard_B2ms"
    node_count = 1
    max_pods   = 110
    mode = "User"
    vnet_subnet_id = var.var_subnet_id

    lifecycle {
    ignore_changes = [
      upgrade_settings,
      node_labels,
      node_taints,
      tags
    ]
  }
}