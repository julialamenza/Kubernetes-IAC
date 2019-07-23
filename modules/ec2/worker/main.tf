# EKS Worker Nodes Resources

###Create IAM ROLE
resource "aws_iam_role" "node" {
  name = "${var.cluster-name}-EDO-EKS-node-role"

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
  vpc_id      = "${var.vpc-id}"

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
/*
####Rules for SG 
resource "aws_security_group" "node-ingress" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.workers.id}"
  source_security_group_id = "${aws_security_group.workers.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group" "node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.workers.id}"
  source_security_group_id = "${aws_security_group.cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-ingress-bastion" {
  cidr_blocks       = ["10.233.104.6/32"]
  description              = "Allow Bastion SSH ACCESS"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.workers.id}"
  to_port                  = 22
  type                     = "ingress"
}
*/
/*
# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/amazon-eks-nodegroup.yaml
locals {
  node-userdata = <<USERDATA
#!/bin/bash -xe
CA_CERTIFICATE_DIRECTORY=/etc/kubernetes/pki
CA_CERTIFICATE_FILE_PATH=$CA_CERTIFICATE_DIRECTORY/ca.crt
mkdir -p $CA_CERTIFICATE_DIRECTORY
echo "${aws_eks_cluster.eks.certificate_authority.0.data}" | base64 -d >  $CA_CERTIFICATE_FILE_PATH
INTERNAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
sed -i s,MASTER_ENDPOINT,${aws_eks_cluster.eks.endpoint},g /var/lib/kubelet/kubeconfig
sed -i s,CLUSTER_NAME,${var.cluster-name},g /var/lib/kubelet/kubeconfig
sed -i s,REGION,${var.aws-region},g /etc/systemd/system/kubelet.service
sed -i s,MAX_PODS,20,g /etc/systemd/system/kubelet.service
sed -i s,MASTER_ENDPOINT,${aws_eks_cluster.eks.endpoint},g /etc/systemd/system/kubelet.service
sed -i s,INTERNAL_IP,$INTERNAL_IP,g /etc/systemd/system/kubelet.service
DNS_CLUSTER_IP=10.100.0.10
if [[ $INTERNAL_IP == 10.* ]] ; then DNS_CLUSTER_IP=172.20.0.10; fi
sed -i s,DNS_CLUSTER_IP,$DNS_CLUSTER_IP,g /etc/systemd/system/kubelet.service
sed -i s,CERTIFICATE_AUTHORITY_FILE,$CA_CERTIFICATE_FILE_PATH,g /var/lib/kubelet/kubeconfig
sed -i s,CLIENT_CA_FILE,$CA_CERTIFICATE_FILE_PATH,g  /etc/systemd/system/kubelet.service
systemctl daemon-reload
systemctl restart kubelet
USERDATA
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
*/
/*
###Create EC2 Instance
resource "aws_launch_configuration" "eks" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.node.name}"
  image_id                    = "${var.worker-image}"
  instance_type               = "${var.node-instance-type-worker}"
  name_prefix                 = "${var.cluster-name}-eks-"
  security_groups             = ["${aws_security_group.workers.id}"]
  user_data_base64            = "${base64encode(local.node-userdata)}"
  key_name                    = "${var.ec2key}"

  lifecycle {
    create_before_destroy = true
  }
}
*/
###Autoscaling Group
  resource "aws_launch_configuration" "eks" {
  name_prefix   = "EDO-EKS-Tolling"
  image_id      = "${var.worker-image}"
  instance_type = "${var.instance-type}"
}

resource "aws_autoscaling_group" "eks" {
  launch_configuration = "${aws_launch_configuration.eks.id}"
  desired_capacity     = "${var.desired-capacity}"
  max_size             = "${var.max-size}"
  min_size             = "${var.min-size}"
  name                 = "${var.cluster-name}-EDO-EKS-Tolling"
  vpc_zone_identifier  = ["${var.cluster_subnet}"]

  tag {
    key                 = "Name"
    value               = "${var.cluster-name}-EDO-EKS-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}