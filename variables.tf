
variable "factoryName" {
  type        = string
  description = "(Required) Data Factory Name"
}

variable "AzureBlobStorage1_connectionString" {
  type        = string
  description = "(Required) AzureBlobStorage1_connectionString"
}

variable "linkedService1_secretAccessKey" {
  type        = string
  description = "(Required) linkedService1_secretAccessKey"
}

variable "linkedService2_password" {
  type        = string
  description = "(Required)linkedService2_password"
}

variable "linkedService1_properties_typeProperties_accessKeyId" {
  type        = string
  description = "(Required) linkedService1_properties_typeProperties_accessKeyId"
}

variable "linkedService2_properties_typeProperties_host" {
  type        = string
  description = "(Required) linkedService2_properties_typeProperties_host"
}

variable "linkedService2_properties_typeProperties_userId" {
  type        = string
  description = "(Required)linkedService2_password"
}







