##############
  ## VPC VARs ##
###############

data "aws_availability_zones" "available" {}

variable "vpc_cidr" {
  default = "10.233.104.0/24"
}

variable "null_list" {
  default = "0.0.0.0/0"
}

variable "cidrs" {
  type = "map"

  default = {
    priv1      = "10.233.104.0/28"
    public-NAT = "10.233.104.16/28"
    priv_WIN   = "10.233.104.32/28"
    priv2      = "10.233.104.48/28"
    priv_tool1 = "10.233.104.64/28"
    priv_tool2 = "10.233.104.80/28"
    priv_tool3 = "10.233.104.96/28"
    priv_mon1  = "10.233.104.112/28"
    priv_mon2  = "10.233.104.128/28"
    priv_mon3  = "10.233.104.144/28"
  }

  
}
################################################################################################

######################################## Instance Variables ####################################

variable "automation_ami" {
  description = " AMI used in automation"
  default     = "ami-0780a68ed0e48f33f"
}

variable "automation_ami_amazon" {
  description = " AMI used in automation"
  default     = "ami-0cc293023f983ed53"
}

variable "instance_type_automation" {
  description = "Instance Type"
  default     = "t2.micro"
}

variable "aws_subnet_Subnet_priv1" {
  description = "Priv1 subnet ID"
  default     = ""
}

variable "key" {
  description = "ssh key"
  default     = "VDF-DE-TEST"
}

variable "privIPs" {
  description = "Private IP's"
  type        = "map"

  default = {
    automation = "10.233.104.55"
  }
}

#######################################################################################
#################################################### EKS #############################
variable "node-instance-type-tool" {
  default     = "t2.micro"
  type        = "string"
  description = "Worker Node EC2 instance type"
}
variable "min-size-tool" {
  default     = 2
  type = "string"
  description = "Autoscaling minimum node capacity"
}
variable "max-size-tool" {
  default     = 3
  type = "string"

  description = "Autoscaling maximum node capacity"
}

variable "desired-capacity-tool" {
  default     = 2
 

  description = "Autoscaling Desired node capacity"
}

variable "eks-tooling-name" {
  default     = "EDO-EKS-Tolling"
  description = "Cluster name"
}
variable "aws_region" {
  default     = ""
  description = "Aws Region"
}
variable "ami-tool" {
  default = "ami-0780a68ed0e48f33f"
}

variable "ami-aws-eks" {
  default = "ami-0d741ed58ca5b342e"
}

variable "tool-instance-type" {
  default = "t2.micro"
}
variable "dmz_eip_id" {
  default = ""
}

variable "k8s-version" {
  default     = "1.12"
  type        = "string"
  description = "Required K8s version"
}
