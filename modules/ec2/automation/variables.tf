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

variable "instance_name" {
  type        = "string"
  description = "Machine name"
  default     = ""
}

variable "env" {
  type        = "string"
  description = "machine env"
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
