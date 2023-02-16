resource "aws_instance" "vpn" {
  ami             = var.vpn_image
  instance_type   = var.vpn_machine_type
  key_name        = var.ami_key_pair_name
  tags            = {
                      Purpose = var.vpn_server_tag
                    }
  subnet_id       = aws_subnet.public-subnet.id
  root_block_device  {
      volume_size = var.vpn_disk_size
  }
}

resource "aws_instance" "gitlab" {
  ami               = var.gitlab_image
  instance_type     = var.gitlab_machine_type
  key_name          = var.ami_key_pair_name 
  tags              = {
                        Purpose = var.gitlab_server_tag
                      }
  subnet_id         = aws_subnet.public-subnet.id
  root_block_device  {
        volume_size = var.gitlab_disk_size
  }
}
