############################### ELB VARIABLES

variable "cluster-name" {
  default     = ""
  type        = "string"
  description = "The name of your EKS Cluster"
}
variable "cluster_subnet" {
  description = "reserved ip's map for SubNets"
  type        = "list"
}

#################TAG VARIABLES
variable "tag_name" {
  type        = "string"
  description = "Machine name"
  default     = ""
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
variable "tag_name_eip" {
}
