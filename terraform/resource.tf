# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "eepockey"
  public_key = "${file("${var.key_path}")}"
}

# Define webserver inside the public subnet
resource "aws_instance" "ci" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("jenkins.sh")}"

  tags {
    Name = "ciserver"
  }
}

# Define database inside the private subnet
resource "aws_instance" "deployment" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.private-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdeploy.id}"]
   source_dest_check = false
   depends_on = ["aws_nat_gateway.eepoc-nat-gw"]
   user_data = "${file("userdata.sh")}"
  tags {
    Name = "deployment"
  }
}




