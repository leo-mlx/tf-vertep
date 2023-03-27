resource "aws_lb_target_group" "vertep-group" {
  name     = "vertep-lb-group"
  port     = var.vertep-port
  protocol = "TCP"
  vpc_id   = aws_vpc.VPN_attached_network.id
}

resource "aws_lb_target_group" "vertep-group-ssl" {
  name     = "vertep-lb-group-ssl"
  port     = var.vertep-port-ssl
  protocol = "TCP"
  vpc_id   = aws_vpc.VPN_attached_network.id
}


resource "aws_lb_target_group_attachment" "vertep-att" {
  for_each = var.deploy_cluster

  target_group_arn = aws_lb_target_group.vertep-group.arn
  target_id        = aws_instance.deploy[each.key].id
  port             = var.vertep-port
}

resource "aws_lb_target_group_attachment" "vertep-att-ssl" {
  for_each = var.deploy_cluster

  target_group_arn = aws_lb_target_group.vertep-group-ssl.arn
  target_id        = aws_instance.deploy[each.key].id
  port             = var.vertep-port-ssl
}

resource "aws_lb" "main-lb" {
  name               = "vertep-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.public-subnet.id]

  enable_deletion_protection = false

}

resource "aws_lb_listener" "vertep-listener" {
  load_balancer_arn = aws_lb.main-lb.arn
  port              = var.vertep-port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vertep-group.arn
  }
}

resource "aws_lb_listener" "vertep-listener-ssl" {
  load_balancer_arn = aws_lb.main-lb.arn
  port              = var.vertep-port-ssl
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vertep-group-ssl.arn
  }
}
