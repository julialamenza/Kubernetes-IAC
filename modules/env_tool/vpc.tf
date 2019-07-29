################################# VPC ########################################################################
resource "aws_vpc" "vpc_tool" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = "${
   map(
    "Name", "vfde-edo-eucentral1-vpc-tooling",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
    "kubernetes.io/cluster/${var.eks-tooling-name}", "shared",
   )
  }"
}
##############################################################################################################

############################################# SUBNETS ########################################################
resource "aws_subnet" "SubNet-priv1" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv1"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

 tags = "${
  map(
    "Name", "vfde-edo-eucentral1-subnet-priv.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
  )
 }"
}


resource "aws_subnet" "SubNet-public-NAT" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["public-NAT"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = "${
  map(
    "Name", "vfde-edo-eucentral1-subnet-public.nat.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
  )
 }"
}

resource "aws_subnet" "SubNet-priv_WIN" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv_WIN"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

 tags = "${
  map(
    "Name", "vfde-edo-eucentral1-subnet-priv.win.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
  )
 }"
}

resource "aws_subnet" "SubNet-priv2" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv2"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

 tags = "${
  map(
    "Name", "vfde-edo-eucentral1-subnet-priv.02",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
  )
 }"
}

resource "aws_subnet" "SubNet-priv_tool1" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv_tool1"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = "${
   map(
    "Name", "vfde-edo-eucentral1-subnet-priv.tooling.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
    "kubernetes.io/cluster/${var.eks-tooling-name}", "shared",
   )
  }"
}

resource "aws_subnet" "SubNet-priv_tool2" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv_tool2"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags = "${
   map(
    "Name", "vfde-edo-eucentral1-subnet-priv.tooling.02",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
    "kubernetes.io/cluster/${var.eks-tooling-name}", "shared",
   )
  }"
}

resource "aws_subnet" "SubNet-priv_tool3" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv_tool3"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

  tags = "${
   map(
    "Name", "vfde-edo-eucentral1-subnet-priv.tooling.03",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
    "kubernetes.io/cluster/${var.eks-tooling-name}", "shared",
   )
  }"
}

resource "aws_subnet" "SubNet-priv_mon1" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv_mon1"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

   tags = "${
   map(
    "Name", "vfde-edo-eucentral1-subnet-priv.monitoring.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
  }
  
resource "aws_subnet" "SubNet-priv_mon2" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv_mon2"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"
 tags = "${
   map(
    "Name", "vfde-edo-eucentral1-subnet-priv.monitoring.02",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
  }

resource "aws_subnet" "SubNet-priv_mon3" {
  vpc_id                  = "${aws_vpc.vpc_tool.id}"
  cidr_block              = "${var.cidrs["priv_mon3"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

 tags = "${
   map(
    "Name", "vfde-edo-eucentral1-subnet-priv.monitoring.03",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
  }
####################################################################################################################################################
############################################################# Internet Gateway #####################################################################

resource "aws_internet_gateway" "tool_igw" {
  vpc_id = "${aws_vpc.vpc_tool.id}"

 tags = "${
   map(
    "Name", "vfde-edo-eucentral1-igw-tooling.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
}
########################################################## Nat Gateway #######################################################################
#----> Elastic IP for Nat Gateway
resource "aws_eip" "dmz_nat_eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.tool_igw"]

  tags ="${
    map(
      "Name", "vfde-edo-eucentral1-eip-nat.gateway.01",
      "Environment", "${var.env_tooling}",
      "PONumber", "${var.po_number}",
      "LMEntity", "${var.lm_entity}",
      "BU", "${var.bu}",
      "Project", "${var.project_tooling}",
      "ManagedBy", "${var.managed}",
      "SecurityZone", "${var.security_zone-tooling}",
      "Confidentiality", "${var.confidentiality-tooling}",
      "TaggingVersion", "${var.tag-version}",
      "BusinessService", "${var.bs}",
      "Terraform", "true",
    )
   }"
 }

#----> Nat Gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = "${aws_eip.dmz_nat_eip.id}"
  subnet_id     = "${aws_subnet.SubNet-public-NAT.id}"
  
 tags = "${
   map(
    "Name", "vfde-edo-eucentral1-natgw-natgw.tooling.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
  }
####################################################################################################################################################

########################################### Route table: attach Internet Gateway ###################################################################
#----------------> RT for Nat Gateway (Internet traffic)
resource "aws_route_table" "dmz_public_rt" {
 vpc_id = "${aws_vpc.vpc_tool.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat-gateway.id}"
  }

  tags = "${
   map(
    "Name", "vfde-edo-eucentral1-rt-public.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
  }

#----------------> Tool RT (default)
resource "aws_default_route_table" "tool_priv1_rt" {
  default_route_table_id = "${aws_vpc.vpc_tool.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tool_igw.id}"
  }

 tags = "${
   map(
    "Name", "vfde-edo-eucentral1-rt-default.tooling.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
}
####################################################################################################################################################
###################################### Route table association with private subnets ################################################################
resource "aws_route_table_association" "dmz_assoc_a" {
  subnet_id      = "${aws_subnet.SubNet-public-NAT.id}"
  route_table_id = "${aws_route_table.dmz_public_rt.id}"
}
resource "aws_route_table_association" "tool_priv1_assoc_a" {
  subnet_id      = "${aws_subnet.SubNet-priv2.id}"
  route_table_id = "${aws_default_route_table.tool_priv1_rt.id}"
}
####################################################################################################################################################
############################################ Security group #######################################################################################
resource "aws_security_group" "automation" {
  name = "vfde-edo-eucentral1-sg-instance.automation.01"
  vpc_id = "${aws_vpc.vpc_tool.id}"

  ingress {                               ### Role to test connectivity (just add access to Celfocus network on VDF PT LX)
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["213.30.18.1/32"]
  }
  /*ingress {                               ### ORIGINAL ROLE
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }*/

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${var.null_list}"]
  }
tags = "${
   map(
    "Name", "vfde-edo-eucentral1-sg-instance.automation.01",
    "Environment", "${var.env_tooling}",
    "PONumber", "${var.po_number}",
    "LMEntity", "${var.lm_entity}",
    "BU", "${var.bu}",
    "Project", "${var.project_tooling}",
    "ManagedBy", "${var.managed}",
    "SecurityZone", "${var.security_zone-tooling}",
    "Confidentiality", "${var.confidentiality-tooling}",
    "TaggingVersion", "${var.tag-version}",
    "BusinessService", "${var.bs}",
    "Terraform", "true",
   )
   }"
  }
####################################################################################################################################################