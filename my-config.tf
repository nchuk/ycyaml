terraform {
   required_providers {
     yandex = {
       source = "yandex-cloud/yandex"
     }
   }
 }
  
 provider "yandex" {
   token  =  "y0_AgAAAABRkfxiAATuwQAAAADeW5oVB9vwdoPwRQWZGG6RYAvngEAIMqI"
   cloud_id  = "b1gm4nvd8cu3vjn7lti4"
   folder_id = "b1g2qq87k8cgqra1nfp7"
   zone      = "ru-central1-a"
 }

resource "yandex_compute_instance" "vm-1" {
  name = "from-terraform-vm"
  platform_id = "standard-v1"
  zone = "ru-central1-a"
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = fd85lavtfgpn9fa7pkoc
    }
  }
 
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
 
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
 
resource "yandex_vpc_network" "network-1" {
  name = "from-terraform-network"
}
 
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "from-terraform-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["10.2.0.0/16"]
}
 
output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
 
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
 