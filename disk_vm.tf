resource "yandex_compute_disk" "vdisk" {
  count   = 3
  name  = "vdisk-${count.index + 1}"
  size  = 1
}


resource "yandex_compute_instance" "storage" {
  depends_on = [yandex_compute_disk.vdisk]
  name = "storage"
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

  dynamic "secondary_disk" {

   for_each = { for vd in yandex_compute_disk.vdisk[*]: vd.name=> vd }
   content {

     disk_id = secondary_disk.value.id
   }
  }

  scheduling_policy {
    preemptible = var.vms_instance_conf["default"].preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_instance_conf["default"].nat
  }
  metadata = {
    serial-port-enable = var.vms_metadata["vm_default"].serial-port-enable
    ssh-keys           = local.ssh-key
  }
}