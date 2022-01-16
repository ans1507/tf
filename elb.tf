resource "aws_elb" "webserver_elb" {
  name               = "webserverelb"
  #availability_zones = ["${var.azs}"]
  subnets = aws_subnet.Public.*.id
  security_groups = ["${aws_security_group.sg.id}"] 

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
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = aws_instance.webserver.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "server-elb"
  }
}
output "elb_dns" {
    value = "${aws_elb.webserver_elb.dns_name}"
  
}
