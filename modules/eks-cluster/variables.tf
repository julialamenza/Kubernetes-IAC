###################################################### EKS VARIABLES ##################################################################

variable "aws_region" {
  description = "used region"
  default = "eu-central-1"
}

variable "aws_profile" {
  description = "aws used profile"
  default = ""
}
data "aws_availability_zones" "available" {}

variable "vpc_cidr" {
  description = "range of ips used in vpc"
  default = "var.vpc_cidr"
}
variable "cluster_subnet" {
  description = "reserved ip's map for SubNets"
  type        = "list"
}
variable "tool_vpc_id" {
  description = "vpc cidr block"
  default = ""
}




#################################### Compute modules ########################################

# Variables Configuration for EKS

variable "cluster-name" {
  default     = ""
  type        = "string"
  description = "The name of your EKS Cluster"
}

variable "iam_role_cluster" {
}
variable "sg_cluster" {
}
variable "tag_env" {
}
variable "tag_po" {
}
variable "tag_lm" {
}
variable "tag_bu" {
}
variable "tag_project" {
}
variable "tag_managed" {
}
variable "tag_sz" {
}
variable "tag_confidentiality" {
}
variable "tag_version" {
}
variable "tag_bs" {
}


