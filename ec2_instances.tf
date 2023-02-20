resource "aws_network_interface" "vpn" {
  subnet_id          = aws_subnet.public-subnet.id
  private_ips        = ["100.69.0.114"]
  source_dest_check  = false
  security_groups    = [aws_security_group.ingress-all.id]
  tags = {
    Name = "vpn_primary_interface"
  }
}

resource "aws_network_interface" "gitlab" {
  subnet_id          = aws_subnet.public-subnet.id
  source_dest_check  = false
  private_ips        = ["100.69.0.136"]
  security_groups    = [aws_security_group.ingress-all.id]
  tags = {
    Name = "gitlab_primary_interface"
  }
}

resource "aws_instance" "vpn" {
  ami             = var.vpn_image
  instance_type   = var.vpn_machine_type
  network_interface {
    network_interface_id = aws_network_interface.vpn.id
    device_index         = 0
  }
  key_name        = var.ami_key_pair_name
  tags            = {
                      Purpose = var.vpn_server_tag
                    }
  root_block_device  {
      volume_size = var.vpn_disk_size
  }
}

resource "aws_instance" "gitlab" {
  ami               = var.gitlab_image
  instance_type     = var.gitlab_machine_type
  network_interface {
    network_interface_id = aws_network_interface.gitlab.id
    device_index         = 0
  }
  key_name          = var.ami_key_pair_name 
  tags              = {
                        Purpose = var.gitlab_server_tag
                      }
  root_block_device  {
        volume_size = var.gitlab_disk_size
  }
}
