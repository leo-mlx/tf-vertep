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

variable "nats_cluster" {
  type = map(any)
  default = {
    "nats1" = "100.69.1.111"
    "nats2" = "100.69.1.19"
    "nats3" = "100.69.1.28"
  }
}
#################
variable "mongo_server_image" {
  type    = string
  default = "ami-0d1ddd83282187d18"
}

variable "mongo_server_type" {
  type    = string
  default = "t3a.large"
}

variable "mongo_disk_size" {
  type    = number
  default = 20
}

variable "mongo_server_tag" {
  type    = string
  default = "mongo cluster"
}

variable "mongo_volume_size" {
  type    = string
  default = 100
}

variable "mongo_cluster" {
  type = map(any)
  default = {
    "mongo1" = "100.69.1.30"
    "mongo2" = "100.69.1.31"
    "mongo3" = "100.69.1.32"
  }
}
##################
variable "lfront_server_image" {
  type    = string
  default = "ami-0d1ddd83282187d18"
}

variable "lfront_server_type" {
  type    = string
  default = "t3a.large"
}

variable "lfront_disk_size" {
  type    = number
  default = 20
}

variable "lfront_server_tag" {
  type    = string
  default = "legacy frontend"
}
##################
variable "zabbix_server_image" {
  type    = string
  default = "ami-0d1ddd83282187d18"
}

variable "zabbix_server_type" {
  type    = string
  default = "t3a.large"
}

variable "zabbix_disk_size" {
  type    = number
  default = 100
}

variable "zabbix_server_tag" {
  type    = string
  default = "zabbix server"
}
##################

variable "volume_zone" {
  type    = string
  default = "eu-central-1a"
}
