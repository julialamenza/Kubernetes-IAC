############################# Automation Instance Variables #######################
variable "key" {
  description = "ssh key"
}

variable "security_group" {
  description = "SG used"
}

variable "subnet_id" {
  description = "subnet used"
}

variable "private_ip" {
  type        = "string"
  description = "private ip"
  default     = ""
}

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

variable "public_ip" {
  type        = "string"
  description = "associate_public_ip_address"
}

variable "instance_type_automation" {
  description = "Instance Type"
  default     = ""
}


variable "ami" {
  description = "AMI type"
  }

####################################################################################
