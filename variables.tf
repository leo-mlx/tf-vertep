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

variable "vpn_disk_size" {
  type    = number
  default = 20
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
  default = "m6i.large"
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
variable "deploy_instance_image" {
  type    = string
  default = "ami-0d1ddd83282187d18"
}

variable "deploy_server_type" {
  type    = string
  default = "t3a.large"
}

variable "deploy_disk_size" {
  type    = number
  default = 100
}

variable "deploy_server_tag" {
  type    = string
  default = "deploy server"
}

variable "deploy_foundary_server_type" {
  type    = string
  default = "t2.medium"
}

variable "deploy_foundary_server_tag" {
  type    = string
  default = "deploy server for foundary"
}

variable "deploy_cluster" {
  type = map(any)
  default = {
    "deploy1" = "100.69.1.41"
    "deploy2" = "100.69.1.42"
  }
}

variable "deploy_foundary" {
  type    = string
  default = "100.69.1.40"
}
##################
variable "volume_zone" {
  type    = string
  default = "eu-central-1a"
}

variable "vertep-port-ssl" {
  type    = string
  default = "443"
}

variable "vertep-port" {
  type    = string
  default = "80"
}
