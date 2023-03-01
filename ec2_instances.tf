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

#Creating interfaces for NATS cluster
resource "aws_network_interface" "nats1" {

  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "nats1_primary_interface"
  }
}

resource "aws_network_interface" "nats2" {
  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "nats2_primary_interface"
  }
}

resource "aws_network_interface" "nats3" {
  subnet_id         = aws_subnet.private-subnet.id
  source_dest_check = false
  security_groups   = [aws_security_group.ingress-all.id]
  tags = {
    Name = "nats3_primary_interface"
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

#Creating NATS cluster with 3 VMs
resource "aws_instance" "nats1" {
  ami           = var.nats_server_image
  instance_type = var.nats_server_type
  network_interface {
    network_interface_id = aws_network_interface.nats1.id
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

resource "aws_instance" "nats2" {
  ami           = var.nats_server_image
  instance_type = var.nats_server_type
  network_interface {
    network_interface_id = aws_network_interface.nats2.id
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

resource "aws_instance" "nats3" {
  ami           = var.nats_server_image
  instance_type = var.nats_server_type
  network_interface {
    network_interface_id = aws_network_interface.nats3.id
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
##################################
