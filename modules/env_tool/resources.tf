############################################# Call Resources Modules ######################################################
module "AUTOMATION" {
  source = "../ec2/automation"
  key                       = "${var.key}"
  ami                       = "${var.automation_ami_amazon}"
  instance_type_automation  = "${var.instance_type_automation}"
  security_group            = "${aws_security_group.automation.id}"
  subnet_id                 = "${aws_subnet.SubNet-priv2.id}"
  private_ip                = "${var.privIPs["automation"]}"
  public_ip                 = "true"
  tag_name                  = "vfde-edo-eucentral1-ec2-automation.01"
  tag_env                   = "${var.env_tooling}"
  tag_po                    = "${var.po_number}"
  tag_lm                    = "${var.lm_entity}"
  tag_bu                    = "${var.bu}"
  tag_project               = "${var.project_tooling}"
  tag_managed               = "${var.managed}"
  tag_sz                    = "${var.security_zone-tooling}"
  tag_confidentiality       = "${var.confidentiality-tooling}"
  tag_version               = "${var.tag-version}"
  tag_bs                    = "${var.bs}"
  tag_name_eip              = "vfde-edo-eucentral1-eip-ec2.automation.01"
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
  iam_role_cluster          = "vfde-edo-eucentral1-role-cluster.tooling.01"
  sg_cluster                = "vfde-edo-eucentral1-sg-cluster.tooling.01"
  tag_env                   = "${var.env_tooling}"
  tag_po                    = "${var.po_number}"
  tag_lm                    = "${var.lm_entity}"
  tag_bu                    = "${var.bu}"
  tag_project               = "${var.project_tooling}"
  tag_managed               = "${var.managed}"
  tag_sz                    = "${var.security_zone-tooling}"
  tag_confidentiality       = "${var.confidentiality-tooling}"
  tag_version               = "${var.tag-version}"
  tag_bs                    = "${var.bs}"
}

/*CODE FOR EKS WITH GDC IMAGE
module "EKS-tool" {
  source = "../eks-cluster/"
  cluster-name       = "${var.eks-tooling-name}"
  aws_region         = "${var.aws_region}"
  tool_vpc_id = "${aws_vpc.vpc_tool.id}"
  cluster_subnet = [ "${aws_subnet.SubNet-priv_tool1.id}", "${aws_subnet.SubNet-priv_tool2.id}", "${aws_subnet.SubNet-priv_tool3.id}" ]
 }
*/


##########################################################################################################################
############################################# Call ELB Module ###########################################################
module "ELB-tool" {
  source  = "../elb-tool/"
  cluster_subnet = [ "${aws_subnet.SubNet-priv_tool1.id}", "${aws_subnet.SubNet-priv_tool2.id}", "${aws_subnet.SubNet-priv_tool3.id}" ]
  tag_name                  = "vfde-edo-eucentral1-elb-tooling"
  tag_env                   = "${var.env_tooling}"
  tag_po                    = "${var.po_number}"
  tag_lm                    = "${var.lm_entity}"
  tag_bu                    = "${var.bu}"
  tag_project               = "${var.project_tooling}"
  tag_managed               = "${var.managed}"
  tag_sz                    = "${var.security_zone-tooling}"
  tag_confidentiality       = "${var.confidentiality-tooling}"
  tag_version               = "${var.tag-version}"
  tag_bs                    = "${var.bs}"
  tag_name_eip              = "vfde-edo-eucentral1-elb-tooling"
  }  


/*
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
}
*/