data "yandex_compute_image" "ubuntu" {
  family = var.vms_instance_conf["default"].image_family
}

resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]
  count = var.vms_instance_conf["default"].exemplars
  
  name        = "web-${count.index+1}" #Имя ВМ в облачной консоли
  hostname    = "web-${count.index+1}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = var.vms_instance_conf["default"].platform_id


  resources {
    cores         = var.vms_resources["default"].cores
    memory        = var.vms_resources["default"].memory
    core_fraction = var.vms_resources["default"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources["default"].disk_type 
      size     = var.vms_resources["default"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vms_instance_conf["default"].preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_instance_conf["default"].nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = var.vms_metadata["vm_default"].serial-port-enable
    ssh-keys           = local.ssh-key
  }
}