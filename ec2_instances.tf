resource "aws_network_interface" "vpn" {
  subnet_id         = aws_subnet.public-subnet.id
  private_ips       = ["100.69.0.114"]
  source_dest_check = false
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "vpn_primary_interface"
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

###################################### Adding deploy instances and interfaces
resource "aws_network_interface" "deploy_foundary" {
  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  private_ips       = [var.deploy_foundary]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = var.deploy_foundary_server_tag
  }
}

resource "aws_network_interface" "deploy" {
  for_each = var.deploy_cluster

  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  private_ips       = [format("%s", each.value)]
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = format("%s_primary_interface", each.key)
  }
}

resource "aws_instance" "deploy" {
  for_each = var.deploy_cluster

  ami           = var.deploy_instance_image
  instance_type = var.deploy_server_type
  network_interface {
    network_interface_id = aws_network_interface.deploy[each.key].id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.deploy_server_tag
  }
  root_block_device {
    volume_size = var.deploy_disk_size
  }
}

resource "aws_instance" "deploy_foundary" {
  ami           = var.deploy_instance_image
  instance_type = var.deploy_foundary_server_type
  network_interface {
    network_interface_id = aws_network_interface.deploy_foundary.id
    device_index         = 0
  }
  key_name = var.ami_key_pair_name
  tags = {
    Purpose = var.deploy_server_tag
  }
  root_block_device {
    volume_size = var.deploy_disk_size
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
