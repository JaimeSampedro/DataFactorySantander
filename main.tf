provider "azurerm" {
    version = "~>1.19"
}

resource "azurerm_resource_group" "main" {
      name     = "DataMov"
      location = "West Europe"
}

resource "azurerm_template_deployment" "main" {
      name                = "ADFApp-ARM"
      resource_group_name = "${azurerm_resource_group.main.name}"
      
      template_body = "${file("${path.module}/DataMoveWithRepoLink/ARMTemplateForFactory.json")}"
      
      parameters = {
        "factoryName" = var.factoryName
        "FileServerInbound_password" = var.FileServerInbound_password
        "FileServerOutbound_password" =var.FileServerOutbound_password
        "FileServerInbound_properties_typeProperties_host" = var.FileServerInbound_properties_typeProperties_host
        "FileServerInbound_properties_typeProperties_userId" = var.FileServerInbound_properties_typeProperties_userId
        "FileServerOutbound_properties_typeProperties_host" = var.FileServerOutbound_properties_typeProperties_host
        "FileServerOutbound_properties_typeProperties_userId" = var.FileServerOutbound_properties_typeProperties_userId
        "integrationRuntimeLinked_properties_typeProperties_linkedInfo_resourceId" = var.integrationRuntimeLinked_properties_typeProperties_linkedInfo_resourceId
      }
      
      deployment_mode = "Incremental"
}


