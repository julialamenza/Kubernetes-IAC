############################################# Call Resources Modules ######################################################
module "AUTOMATION" {
  source = "../ec2/automation"
  instance_name            = "automation"
  key                      = "${var.key}"
  ami                      = "${var.automation_ami_amazon}"
  instance_type_automation = "${var.instance_type_automation}"
  security_group           = "${aws_security_group.automation.id}"
  subnet_id = "${aws_subnet.SubNet-priv2.id}"
  private_ip = "${var.privIPs["automation"]}"
  public_ip = "true"
  env       = "tool"
}
##########################################################################################################################
############################################# Call EKS Modules ######################################################
module "EKS-tool" {
  source             = "../eks-cluster/"
  cluster-name       = "${var.eks-tooling-name}"
  aws-region         = "${var.aws_region}"
  tool_vpc_id = "${aws_vpc.vpc_tool.id}"
  cluster_subnet = [ "${aws_subnet.SubNet-priv_tool1.id}", "${aws_subnet.SubNet-priv_tool2.id}", "${aws_subnet.SubNet-priv_tool3.id}" ]
  k8s-version        = "${var.k8s-version}"
  node-instance-type = "${var.node-instance-type-tool}"
  desired-capacity   = "${var.desired-capacity-tool}"
  max-size           = "${var.max-size-tool}"
  min-size           = "${var.min-size-tool}"
  ec2key = "${var.key}"
  worker-image = "${var.ami-aws-eks}"
}

/*CODE FOR EKS WITH GDC IMAGE
module "EKS-tool" {
  source = "../eks-cluster/"
  cluster-name       = "${var.eks-tooling-name}"
  aws_region         = "${var.aws_region}"
  tool_vpc_id = "${aws_vpc.vpc_tool.id}"
  cluster_subnet = [ "${aws_subnet.SubNet-priv_tool1.id}", "${aws_subnet.SubNet-priv_tool2.id}", "${aws_subnet.SubNet-priv_tool3.id}" ]
 }

##########################################################################################################################
############################################# Call workers Modules ######################################################
module "workers-tool" {
  source = "../ec2/worker/"
  cluster_subnet = [ "${aws_subnet.SubNet-priv_tool1.id}", "${aws_subnet.SubNet-priv_tool2.id}", "${aws_subnet.SubNet-priv_tool3.id}" ]
  vpc-id = "${aws_vpc.vpc_tool.id}"
  worker-image = "${var.ami-tool}"
  cluster-name       = "${var.eks-tooling-name}"
  desired-capacity     = "${var.desired-capacity-tool}"
  max-size             = "${var.max-size-tool}"
  min-size             = "${var.min-size-tool}"
  instance-type        = "${var.tool-instance-type}"
}*/