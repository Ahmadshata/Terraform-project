
resource "aws_lb" "my-lb" {
  name               = var.lb-name
  internal           = var.lb_type
  load_balancer_type = "application"
  security_groups    = var.sg
  subnets            = var.subs


}

resource "aws_lb_target_group" "my-tg" {
  name     = var.tg-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  count = 2
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = var.instance-id[count.index]
  port             = 80
}

resource "aws_lb_listener" "my-listener" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }
}


