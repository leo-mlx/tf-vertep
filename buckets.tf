resource "aws_s3_bucket" "docker_images" {
  bucket            = "docker-images-vertep-infra"
}

resource aws_s3_bucket_acl "docker_images_acl" {
  bucket = aws_s3_bucket.docker_images.id
  acl    = "authenticated-read"
}
