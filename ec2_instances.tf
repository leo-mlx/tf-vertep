resource "aws_network_interface" "vpn" {
  subnet_id         = aws_subnet.public-subnet.id
  private_ips       = ["100.69.0.114"]
  source_dest_check = false
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "vpn_primary_interface"
  }
}

resource "aws_network_interface" "gitlab" {
  subnet_id         = aws_subnet.public-subnet.id
  source_dest_check = false
  private_ips       = ["100.69.0.136"]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "gitlab_primary_interface"
  }
}

resource "aws_network_interface" "test" {
  subnet_id         = aws_subnet.public-subnet.id
  source_dest_check = false
  private_ips       = ["100.69.0.115"]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "test_primary_interface"
  }
}

resource "aws_network_interface" "runner" {
  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "runner_primary_interface"
  }
}

resource "aws_network_interface" "lfront" {
  subnet_id         = aws_subnet.public-subnet.id
  source_dest_check = false
  private_ips       = ["100.69.0.116"]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "lfront_primary_interface"
  }
}

resource "aws_network_interface" "zabbix" {
  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  private_ips       = ["100.69.1.20"]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "zabbix_primary_interface"
  }
}

#Creating  NATS cluster
resource "aws_network_interface" "nats" {
  for_each = var.nats_cluster

  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  private_ips       = [format("%s", each.value)]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = format("%s_primary_interface", each.key)
  }
}

resource "aws_instance" "nats" {
  for_each = var.nats_cluster

  #  host_id = each.key
  ami           = var.nats_server_image
  instance_type = var.nats_server_type
  network_interface {
    network_interface_id = aws_network_interface.nats[each.key].id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.nats_server_tag
  }
  root_block_device {
    volume_size = var.nats_disk_size
  }
}
######################################

#Creating Mongo cluster
resource "aws_network_interface" "mongo" {
  for_each = var.mongo_cluster

  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  private_ips       = [format("%s", each.value)]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = format("%s_primary_interface", each.key)
  }

}

resource "aws_instance" "mongo" {
  for_each = var.mongo_cluster

  #  host_id       = each.key
  ami           = var.mongo_server_image
  instance_type = var.mongo_server_type
  network_interface {
    network_interface_id = aws_network_interface.mongo[each.key].id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.mongo_server_tag
  }
  root_block_device {
    volume_size = var.mongo_disk_size
  }
}
######################################

resource "aws_instance" "vpn" {
  ami           = var.vpn_image
  instance_type = var.vpn_machine_type
  network_interface {
    network_interface_id = aws_network_interface.vpn.id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.vpn_server_tag
  }
  root_block_device {
    volume_size = var.vpn_disk_size
  }
}

resource "aws_instance" "gitlab" {
  ami           = var.gitlab_image
  instance_type = var.gitlab_machine_type
  network_interface {
    network_interface_id = aws_network_interface.gitlab.id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.gitlab_server_tag
  }
  root_block_device {
    volume_size = var.gitlab_disk_size
  }
}

resource "aws_instance" "test" {
  ami           = var.test_machine_image
  instance_type = var.test_machine_type
  network_interface {
    network_interface_id = aws_network_interface.test.id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.test_server_tag
  }
  root_block_device {
    volume_size = var.test_disk_size
  }
}

resource "aws_instance" "runner" {
  ami           = var.runner_image
  instance_type = var.runner_machine_type
  network_interface {
    network_interface_id = aws_network_interface.runner.id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.runner_server_tag
  }
  root_block_device {
    volume_size = var.runner_disk_size
  }
}

resource "aws_instance" "lfront" {
  ami           = var.lfront_server_image
  instance_type = var.lfront_server_type
  network_interface {
    network_interface_id = aws_network_interface.lfront.id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.lfront_server_tag
  }
  root_block_device {
    volume_size = var.lfront_disk_size
  }
}

resource "aws_instance" "zabbix" {
  ami           = var.zabbix_server_image
  instance_type = var.zabbix_server_type
  network_interface {
    network_interface_id = aws_network_interface.zabbix.id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.zabbix_server_tag
  }
  root_block_device {
    volume_size = var.zabbix_disk_size
  }
}
