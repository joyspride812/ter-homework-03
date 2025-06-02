resource "yandex_compute_instance" "db" {

  

  for_each = {for vm in local.vms_db_conf: "${vm.name}" => vm }
  
  name        = each.key
  hostname    = each.key
  platform_id = each.value.platform_id


  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = each.value.disk_type
      size = each.value.disk_size
    }
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = var.vms_metadata["vm_default"].serial-port-enable
    ssh-keys           = local.ssh-key
  }
  
}

