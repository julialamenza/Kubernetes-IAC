############################### Automation Instance #########################################
resource "aws_instance" "automation" {
  instance_type          = "${var.instance_type_automation}"
  key_name               = "${var.key}"
  vpc_security_group_ids = ["${var.security_group}"]
  ami                    = "${var.ami}"
  subnet_id              = "${var.subnet_id}"
  #associate_public_ip_address = "${var.public_ip}"                    ###To be deleted??
  private_ip = "${var.private_ip}"

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }
  tags {
    Name      = "${var.instance_name}"
    Env       = "${var.env}"
    Terraform = "true"
  }

  #availability_zone = "${var.availability_zone}"                      ###To be deleted??
}
###############################################################################################


############################# Elastic IP to test connection TMP ###############################
resource "aws_eip" "ip-test-env" {
  instance = "${aws_instance.automation.id}"
  vpc = true
}