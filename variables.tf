variable "vpc_CIDR" {
  type    = string
  default = "100.69.0.0/22"
}

variable "subnet_CIDR" {
  type    = string
  default = "100.69.0.0/24"
}

variable "vpc_zone" {
  type    = string
  default = "eu-central-1a"
}

variable "vpn_image" {
  type    = string
  default = "ami-0d1ddd83282187d18"
}

variable "vpn_machine_type" {
  type    = string
  default = "t3a.large"
}

variable "ami_key_pair_name" {
  type    = string
  default = "leo"
}

variable "vpn_server_tag" {
  type    = string
  default = "VPN server"
}

variable "gitlab_server_tag" {
  type    = string
  default = "Gitlab server"
}

variable "gitlab_image" {
  type    = string
  default = "ami-0913ce6e95f845f29"
}

variable "gitlab_machine_type" {
  type    = string
  default = "t3a.large"
}

variable "vpn_disk_size" {
  type    = number
  default = 20
}

variable "gitlab_disk_size" {
  type    = number
  default = 60
}
