#Persistant volumes for mongo cluster
resource "aws_ebs_volume" "mongo" {
  for_each = var.mongo_cluster

  availability_zone = var.volume_zone
  size              = var.mongo_volume_size
}

resource "aws_volume_attachment" "mongo_att" {
  for_each = var.mongo_cluster

  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.mongo[each.key].id
  instance_id = aws_instance.mongo[each.key].id
}
############################
