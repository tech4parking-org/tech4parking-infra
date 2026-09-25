resource "aws_lb_listener" "website_listener_lb_http" {
  load_balancer_arn = var.website_load_balancer_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_website_lb_target.arn
  }
  # default_action {
  #   type = "redirect"

  #   redirect {
  #     host        = "#{host}"
  #     path        = "/"
  #     port        = "443"
  #     protocol    = "HTTPS"
  #     query       = "#{query}"
  #     status_code = "HTTP_301"
  #   }
  # }
}
