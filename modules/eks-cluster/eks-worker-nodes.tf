# EKS Worker Nodes Resources

variable "node-instance-type" {}
variable "desired-capacity" {}
variable "max-size" {}
variable "min-size" {}
variable "k8s-version" {}
#variable "cluster-name" {}
variable "aws-region" {}
#variable "tool_vpc_id" {}
variable "worker-image" {}
variable "ec2key" {
  
}


###Create IAM ROLE
resource "aws_iam_role" "node" {
  name = "${var.cluster-name}-eks-node-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

###Attachment policy to role
resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.node.name}"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.node.name}"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.node.name}"
}

resource "aws_iam_instance_profile" "node" {
  name = "${var.cluster-name}-eks-node-instance-profile"
  role = "${aws_iam_role.node.name}"
}

###SG
resource "aws_security_group" "workers" {
  name        = "${var.cluster-name}-eks-node-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${var.tool_vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "${var.cluster-name}-eks-node-sg",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

####Rules for SG 
resource "aws_security_group_rule" "node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.workers.id}"
  source_security_group_id = "${aws_security_group.workers.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.workers.id}"
  source_security_group_id = "${aws_security_group.cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-ingress-bastion" {
  cidr_blocks       = ["10.233.104.55/32"]
  description              = "Allow Bastion SSH ACCESS"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.workers.id}"
  to_port                  = 22
  type                     = "ingress"
}

# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_region" "current" {}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}


###Create EC2 Instance
resource "aws_launch_configuration" "eks" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.node.name}"
  image_id                    = "${var.worker-image}"
  instance_type               = "${var.node-instance-type}"
  name_prefix                 = "${var.cluster-name}-eks-"
  security_groups             = ["${aws_security_group.workers.id}"]
  user_data_base64            = "${base64encode(local.node-userdata)}"
  key_name                    = "${var.ec2key}"

  lifecycle {
    create_before_destroy = true
  }
}

###Autoscaling Group
resource "aws_autoscaling_group" "eks" {
  desired_capacity     = "${var.desired-capacity}"
  launch_configuration = "${aws_launch_configuration.eks.id}"
  max_size             = "${var.max-size}"
  min_size             = "${var.min-size}"
  name                 = "${var.cluster-name}-eks-asg"
  vpc_zone_identifier  = ["${var.cluster_subnet}"]

  tag {
    key                 = "Name"
    value               = "${var.cluster-name}-eks-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}