output "config" {
    value = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
}

output "ara_principal_id" {
    value = azurerm_kubernetes_cluster.aks-cluster.kubelet_identity[0].object_id
}