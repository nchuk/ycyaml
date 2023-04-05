source "yandex" "ubuntu-nginx" {
   token               = "y0_AgAAAABRkfxiAATuwQAAAADeW5oVB9vwdoPwRQWZGG6RYAvngEAIMqI"
   folder_id           = "b1g2qq87k8cgqra1nfp7"
   source_image_family = "ubuntu-2004-lts"
   ssh_username        = "ubuntu"
   use_ipv4_nat        = "true"
   image_description   = "my custom ubuntu with nginx"
   image_family        = "ubuntu-2004-lts"
   image_name          = "my-ubuntu-nginx"
   subnet_id           = "e9bul9ifvucubuqn1ban"
   disk_type           = "network-ssd"
   zone                = "ru-central1-a"
 }

 build {
   sources = ["source.yandex.ubuntu-nginx"]

   provisioner "shell" {
     inline = ["sudo apt-get update -y",
           "sudo apt-get install -y nginx",
           "sudo systemctl enable nginx.service"]
   }
 }
 