vms_resources = {
  default={
    cores         = 2
    memory        = 1
    core_fraction = 20
    disk_type     = "network-hdd"
    disk_size     = "10"
  }
}  

vms_instance_conf = {
  default={
    exemplars          = 2
    image_family   = "ubuntu-2004-lts"
    platform_id    = "standard-v3"
    preemptible    = true
    nat            = true
  }
   

}




vms_metadata = {
 vm_default={
  serial-port-enable = 1
}
 }