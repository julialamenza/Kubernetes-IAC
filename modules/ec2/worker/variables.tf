
variable "node-instance-type" {
  default     = ""
  type        = "string"
  description = "Worker Node EC2 instance type"
}

variable "desired-capacity" {
}

variable "max-size" {
}

variable "min-size" {
}

variable "ec2key" {
default =""
}

variable "cluster-name" {
  default     = ""
  type        = "string"
  description = "The name of your EKS Cluster"
}
variable "cluster_subnet" {
  description = "reserved ip's map for SubNets"
  type        = "list"
}
variable "cluster_id" {
  description = "security group id"
  default =""
}
variable "vpc-id" {
  description = "vpc cidr block"
  default = ""
}

variable "worker-image" {
  
}
variable "aws_eks_cluster_eks_endpoint" {
  default = ""
}
variable "instance-type" {
default = ""
  
}

