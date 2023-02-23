resource "aws_iam_group" "s3_group" {
  name = "s3_users"
}

resource "aws_iam_group_policy_attachment" "s3_group_policy" {
  group = aws_iam_group.s3_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

locals {
  users = [
    {
      name : "gitlab",
      groups : [aws_iam_group.s3_group.name]
    }
  ]
}

resource "aws_iam_user" "user" {
  for_each = { for user in local.users : user.name => user }
  name     = each.value.name
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  for_each = { for user in local.users : user.name => user }
  user     = each.value.name
  groups   = each.value.groups
  depends_on = [
    aws_iam_user.user
  ]
}
