resource "aws_instance" "webserver" {
    count = "${length(var.subnet_cidr-pub)}"
  ami = "${var.webserver_ami}"
  instance_type = "${var.webserver_type}"
  security_groups = ["${aws_security_group.sg.id}"]
  subnet_id = "${element(aws_subnet.Public.*.id,count.index)}"
  user_data = "${file("install_httpd.sh")}"

  tags = {
    Name = "Wenserver"
  }   
}
