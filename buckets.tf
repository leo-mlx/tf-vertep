resource "aws_s3_bucket" "docker_images" {
  bucket = "docker-images-vertep-infra"
}

resource aws_s3_bucket_acl "docker_images_acl" {
  bucket = aws_s3_bucket.docker_images.id
  acl    = "authenticated-read"
}

resource "aws_s3_bucket" "backups" {
  bucket = "backup-vertep-infra"
}

resource aws_s3_bucket_acl "backups_acl" {
  bucket = aws_s3_bucket.backups.id
  acl    = "authenticated-read"
}

