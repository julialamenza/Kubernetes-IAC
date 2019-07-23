############################### Bastion Instance #########################################
resource "aws_instance" "bastion" {
  ami                         = "ami-0233214e13e500f77"
  key_name                    = "VDF-DE-TEST"
  instance_type               = "t2.micro"
  security_groups             = ["${var.security_group}"]
  associate_public_ip_address = true
}

###############################################################################################