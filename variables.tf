variable "environment_tag" {
    type = string
    description = "Environment tag value"
}
variable "azure-rg-1" {
    type = string
    description = "resource group 1"
}
variable "loc1" {
    description = "The location for this Lab environment"
    type= string
}
variable "region1-vnet1-name" {
    description = "VNET1 Name"
    type= string
}
variable "region1-vnet1-address-space" {
  description = "VNET address space"
  type = string
}
variable "region1-vnet1-snet1-name" {
  description = "subnet name"
  type = string
}
variable "region1-vnet1-snet1-range" {
  description = "subnet range"
  type = string
}
variable "vmsize-domaincontroller" {
  description = "size of vm for domain controller"
  type = string
}
variable "adminusername" {
  description = "administrator username for virtual machines"
  type = string
}
variable "adminpassword" {
  description = "administrator username for virtual machines"
  type = string
}
variable "rdsh_count" {
  description = "Number of session hosts"
  default     = 1
}
variable "vmsize-sessionhost" {
  description = "Size of the machine to deploy"
  default     = "Standard_DS2_v2"
}
variable "prefix" {
  type        = string
  description = "Prefix of the name of the AVD machine(s)"
}
variable "domain_name" {
  type        = string
  description = "Name of the domain to join"
}
variable "domain_user_upn" {
  type        = string
  description = "Username for domain join (do not include domain name as this is appended)"
}
variable "domain_password" {
  type        = string
  description = "Password of the user to authenticate with the domain"
  sensitive   = true
}
variable "ou_path" {
  default = ""
}
