terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAEA7qkNgaoAATuwQAAAAD0-3d5uvKUhijgQ1uTT6Lm9mxUu_ZRbeo"
  cloud_id  = "b1gptt6ck9gmebgbgkda"
  folder_id = "b1g44ftedn20okjf9fp6"
  zone      = "ru-central1-b"
}

resource "yandex_iam_service_account" "sa" {
  name = "terraform-service"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = "b1g44ftedn20okjf9fp6"
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_compute_image" "ubuntu_2204" {
  source_family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm-1" {
  name = "webapp-1"

  resources {
    cores  = 2
    memory = 1
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.ubuntu_2204.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/marcille/.ssh/yc_key.pub")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "webapp-2"

  resources {
    cores  = 2
    memory = 1
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.ubuntu_2204.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/marcille/.ssh/yc_key.pub")}"
  }
}

resource "yandex_mdb_mysql_database" "db1" {
  cluster_id = yandex_mdb_mysql_cluster.storage.id
  name       = "db1"
}

resource "yandex_mdb_mysql_cluster" "storage" {
  name                = "cluster"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.network-1.id
  version             = "8.0"
  security_group_ids  = [yandex_vpc_security_group.mysql-sg.id]
  deletion_protection = true
  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.subnet-1.id
  }
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = yandex_mdb_mysql_cluster.storage.id
  name       = "user"
  password   = "useruser"
  permission {
    database_name = yandex_mdb_mysql_database.db1.name
    roles         = ["ALL"]
  }
}

resource "yandex_vpc_security_group" "mysql-sg" {
  name       = "mysql-sg"
  network_id = yandex_vpc_network.network-1.id

  ingress {
    description    = "MySQL"
    port           = 3306
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_api_gateway" "api-gateway-1" {
  name        = "api-gateway"
  description = "The greatest API gateway"
  spec        = <<-EOT
    openapi: "3.0.0"
    info:
      version: 1.0.0
      title: My API
    paths:
      /health:
        get:
          summary: Health check
          operationId: health
          responses:
            '200':
              description: Healthy
          x-yc-apigateway-integration:
            type: dummy
            http_code: 200
            http_headers:
              'Content-Type': "text/plain"
            content:
              'text/plain': "Ping!\n"
  EOT
}

output "internal_ip_address_webapp_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "internal_ip_address_webapp_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}

output "external_ip_address_webapp_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_webapp_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}

output "subnet-1" {
  value = yandex_vpc_subnet.subnet-1.id
}
