resource "aws_elb" "eepoc-elb" {
  name               = "eepoc-elb"
  subnets = ["${aws_subnet.public-subnet.id}"]
  security_groups = ["${aws_security_group.sgweb.id}"]
  internal        = false  

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.deployment.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  depends_on = ["aws_instance.deployment"]
  tags = {
    Name = "eepoc-elb"
  }
}
