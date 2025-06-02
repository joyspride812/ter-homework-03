###cloud vars
/*variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
*/



variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default     = "b1g0957cvllhmpkm1egt"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = "b1g2c1epf6je7jon56e3"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}
#################################
### vms vars



variable "vms_resources" {
  type = map(object({
  
    cores         = number
    memory        = number
    core_fraction = number
    disk_type = string
    disk_size = number
 }))
}

variable "vms_instance_conf" {
  type = map(object({
    exemplars      = number
    name           = optional(string)
    hostname       = optional(string)
    image_family   = string
    platform_id    = string
    preemptible    = bool
    nat            = bool
 }))
}

  variable "vms_metadata" {
  type = map(object({
  
    serial-port-enable         = number
   
    
 }))
}

locals { 
    vms_db_conf = [
    {
    name             = "main-db"
      hostname       = "main-db"
      image_family   = "ubuntu-2004-lts"
      platform_id    = "standard-v3"
      preemptible    = true
      nat            = true
      cores          = 2
      memory         = 1
      core_fraction  = 20
      disk_type      = "network-hdd"
      disk_size      = 10
   },
   {
    name             = "replica-db"
      hostname       = "replica-db"
      image_family   = "ubuntu-2004-lts"
      platform_id    = "standard-v3"
      preemptible    = true
      nat            = true
      cores          = 2
      memory         = 2
      core_fraction  = 50
      disk_type      = "network-hdd"
      disk_size      = "20"
   }

]
 ssh-key = "ubuntu:${file("/home/a.moiseenko@TS-TEST.RU/terraform/hw-3/cert/netology.pub")}"
}
  ##############


