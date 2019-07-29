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
    Name              = "${var.tag_name}"
    Environment       = "${var.tag_env}"
    PONumber          = "${var.tag_po}"
    LMEntity          = "${var.tag_lm}"
    BU                = "${var.tag_bu}"
    Project           = "${var.tag_project}"
    ManagedBy         = "${var.tag_managed}"
    SecurityZone      = "${var.tag_sz}"
    Confidentiality   = "${var.tag_confidentiality}"
    TaggingVersion    = "${var.tag_version}"
    BusinessService   = "${var.tag_bs}"
    Terraform         = "true"   
  }

  #availability_zone = "${var.availability_zone}"                      ###To be deleted??
}
###############################################################################################


############################# Elastic IP to test connection TMP ###############################
resource "aws_eip" "ip-test-env" {
  instance = "${aws_instance.automation.id}"
  vpc = true

  tags {
    Name              = "${var.tag_name_eip}"
    Environment       = "${var.tag_env}"
    PONumber          = "${var.tag_po}"
    LMEntity          = "${var.tag_lm}"
    BU                = "${var.tag_bu}"
    Project           = "${var.tag_project}"
    ManagedBy         = "${var.tag_managed}"
    SecurityZone      = "${var.tag_sz}"
    Confidentiality   = "${var.tag_confidentiality}"
    TaggingVersion    = "${var.tag_version}"
    BusinessService   = "${var.tag_bs}"
    Terraform         = "true"   
  }
}