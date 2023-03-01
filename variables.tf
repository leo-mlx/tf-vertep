variable "vpc_CIDR" {
  type    = string
  default = "100.69.0.0/22"
}

variable "subnet_CIDR" {
  type    = string
  default = "100.69.0.0/24"
}

variable "private_subnet_CIDR" {
  type    = string
  default = "100.69.1.0/24"
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
################
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
##############
variable "runner_image" {
  type    = string
  default = "ami-0a291e69a75ba8cae"
}

variable "runner_machine_type" {
  type    = string
  default = "t3a.large"
}

variable "runner_disk_size" {
  type    = number
  default = 60
}

variable "runner_server_tag" {
  type    = string
  default = "gitlab runner"
}
###############
variable "test_machine_image" {
  type    = string
  default = "ami-0d6adc6af818f43fb"
}

variable "test_machine_type" {
  type    = string
  default = "t3a.large"
}

variable "test_disk_size" {
  type    = number
  default = 60
}

variable "test_server_tag" {
  type    = string
  default = "test server"
}
#################
variable "nats_server_image" {
  type    = string
  default = "ami-0753d09c1c386f2b7"
}

variable "nats_server_type" {
  type    = string
  default = "t3a.large"
}

variable "nats_disk_size" {
  type    = number
  default = 60
}

variable "nats_server_tag" {
  type    = string
  default = "nats cluster"
}
