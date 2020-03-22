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
      
      template_body = "${file("${path.module}/arm_code/arm_template.json")}"
      
      parameters = {
        "factoryName" = var.factoryName
        "AzureBlobStorage1_connectionString" = var.AzureBlobStorage1_connectionString
        "linkedService1_secretAccessKey" =var.linkedService1_secretAccessKey
        "linkedService2_password" = var.linkedService2_password
        "linkedService1_properties_typeProperties_accessKeyId" = var.linkedService1_properties_typeProperties_accessKeyId
        "linkedService2_properties_typeProperties_host" = var.linkedService2_properties_typeProperties_host
        "linkedService2_properties_typeProperties_userId" = var.linkedService2_properties_typeProperties_userId
      }
      
      deployment_mode = "Incremental"
}



