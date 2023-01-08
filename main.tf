data "yandex_compute_image" "this" {
  family = var.vm_image_family
}

locals {
  prefix = "stage-"
}

resource "yandex_compute_instance" "this" {
  count = var.vm_count

  name        = "${local.prefix}${var.vm_name}-${count.index}"
  platform_id = "standard-v1"
  zone        = var.az[count.index % length(var.az)]

  labels = var.labels

  resources {
    cores  = 2
    memory = 2
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.this[var.az[count.index]].id}"
    nat = var.allocate_public_ip
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.this.id}"
    }
  }
  
  metadata = {
    ssh-keys = var.public_ssh_key_path != "" ? "ubuntu:${file(var.public_ssh_key_path)}" : "ubuntu:${tls_private_key.ssh_key[0].public_key_openssh}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt upgrade -y", "ping -c 3 8.8.8.8"]

    connection {
      host = self.network_interface.0.nat_ip_address
      type = "ssh"
      user = "ubuntu"
      private_key = "${tls_private_key.ssh_key[0].private_key_openssh}"
    }
  }

  
}