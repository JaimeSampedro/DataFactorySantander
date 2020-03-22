
variable "factoryName" {
  type        = string
  description = "(Required) Data Factory Name"
}

variable "FileServerInbound_password" {
  type        = string
  description = "(Required) FileServerInbound_password"
}

variable "FileServerOutbound_password" {
  type        = string
  description = "(Required) FileServerOutbound_password"
}

variable "FileServerInbound_properties_typeProperties_host" {
  type        = string
  description = "(Required) FileServerInbound_properties_typeProperties_host"
}

variable "FileServerInbound_properties_typeProperties_userId" {
  type        = string
  description = "(Required) FileServerInbound_properties_typeProperties_userId"
}

variable "FileServerOutbound_properties_typeProperties_host" {
  type        = string
  description = "(Required)FileServerOutbound_properties_typeProperties_host"
}

variable "FileServerOutbound_properties_typeProperties_userId" {
  type        = string
  description = "(Required)FileServerOutbound_properties_typeProperties_userId"
}

variable "integrationRuntimeLinked_properties_typeProperties_linkedInfo_resourceId" {
  type        = string
  description = "(Required)integrationRuntimeLinked_properties_typeProperties_linkedInfo_resourceId"
}

