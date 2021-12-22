terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.68.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = "/root/keys/key.json"
  cloud_id = "b1grueplacatchduatm0"
  folder_id = "b1ga9l1gdb6m45ek99hq"
  zone = "ru-central1-a"
}


resource "yandex_compute_instance" "template" {
  name = "vm1"
  count = 1
  boot_disk {
    initialize_params {
      size = "15"
      image_id = "${var.image_id}"
    }
  }
  network_interface {
    nat = true
    subnet_id = "${var.subnet_id}"
  }
  resources {
    cores = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
