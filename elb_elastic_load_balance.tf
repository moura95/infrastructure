resource "aws_alb" "arn_aws_elasticloadbalancing_sa_east_1_613177300792_loadbalancer_app_lb_crypto_tracker_11f6d1c1ce1e60d1" {
  access_logs {
    bucket = ""
  }

  desync_mitigation_mode           = "defensive"
  enable_cross_zone_load_balancing = true
  enable_http2                     = true
  idle_timeout                     = 60
  ip_address_type                  = "ipv4"
  load_balancer_type               = "application"
  name                             = "lb-crypto-tracker"
  security_groups                  = [aws_security_group.lb.id]
  subnet_mapping {
    subnet_id = aws_subnet.subnet_1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.subnet_2.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.subnet_3.id
  }

#  subnets = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]
}

resource "aws_alb_listener" "arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_e30cffcf193359dc" {
  default_action {
    order = 1
    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }

    type = "redirect"
  }

  load_balancer_arn = aws_alb.arn_aws_elasticloadbalancing_sa_east_1_613177300792_loadbalancer_app_lb_crypto_tracker_11f6d1c1ce1e60d1.arn
  port              = 80
  protocol          = "HTTP"
}

resource "aws_alb_listener_certificate" "arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_de4f0126f81cee11_arn_aws_acm_sa_east_1_613177300792_certificate_3fe3ff9b_b9fd_4b50_ba33_f1e2bea439df" {
  certificate_arn = "arn:aws:acm:sa-east-1:613177300792:certificate/3fe3ff9b-b9fd-4b50-ba33-f1e2bea439df"
  listener_arn    = aws_alb_listener.arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_e30cffcf193359dc.arn
}

resource "aws_alb_listener_certificate" "arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_de4f0126f81cee11_arn_aws_acm_sa_east_1_613177300792_certificate_c762560e_876d_449d_9cea_e8d8ab5a80b2" {
  certificate_arn = "arn:aws:acm:sa-east-1:613177300792:certificate/c762560e-876d-449d-9cea-e8d8ab5a80b2"
  listener_arn    = aws_alb_listener.arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_e30cffcf193359dc.arn
}

resource "aws_alb_listener_certificate" "arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_de4f0126f81cee11_arn_aws_acm_sa_east_1_613177300792_certificate_d7e09012_d121_4559_a6e1_269e341962fe" {
  certificate_arn = "arn:aws:acm:sa-east-1:613177300792:certificate/d7e09012-d121-4559-a6e1-269e341962fe"
  listener_arn    = aws_alb_listener.arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_e30cffcf193359dc.arn
}


resource "aws_alb_listener_rule" "crypto-tracker" {
  tags = {
    Name = "crypto-tracker"
  }

  tags_all = {
    Name = "crypto-tracker"
  }

  action {
    order            = 1
    target_group_arn = aws_alb_target_group.arn_aws_elasticloadbalancing_sa_east_1_613177300792_targetgroup_crypto_tracker_788e6c6b8565dd94.arn
    type             = "forward"
  }

  condition {
    host_header {
      values = ["api.cryptotracker.com.br"]
    }

  }

  listener_arn = aws_alb_listener.arn_aws_elasticloadbalancing_sa_east_1_613177300792_listener_app_lb_crypto_tracker_11f6d1c1ce1e60d1_e30cffcf193359dc.arn
  priority     = 3
}



resource "aws_alb_target_group" "arn_aws_elasticloadbalancing_sa_east_1_613177300792_targetgroup_crypto_tracker_788e6c6b8565dd94" {
  deregistration_delay = aws_autoscaling_group.infra_ecs_cluster_devcluster_9ba78d19_ecsautoscalinggroup_1a2hg3uy8d3ah.default_cooldown
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "204"
    path                = "/healthz"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  load_balancing_algorithm_type = "round_robin"
  port                          = 8000
  protocol                      = "HTTP"
  protocol_version              = "HTTP1"
  stickiness {
    cookie_duration = 86400
    type            = "lb_cookie"
  }

  target_type = "instance"
  vpc_id      = aws_vpc.vpc_crypto_tracker.id
}