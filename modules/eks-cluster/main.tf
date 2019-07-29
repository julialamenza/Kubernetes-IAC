# EKS Cluster Resources

resource "aws_iam_role" "cluster" {
  name = "${var.iam_role_cluster}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  tags {
    Environment       = "${var.tag_env}"
    PONumber          = "${var.tag_po}"
    LMEntity          = "${var.tag_lm}"
    BU                = "${var.tag_bu}"
    Project           = "${var.tag_project}"
    ManagedBy         = "${var.tag_managed}"
    SecurityZone      = "${var.tag_sz}"
    Confidentiality   = "${var.tag_confidentiality}"
    TaggingVersion    = "${var.tag_version}"
    BusinessService   = "${var.tag_bs}"
    Terraform         = "true"   
  }
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.cluster.name}"
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.cluster.name}"
}

resource "aws_security_group" "cluster" {
  name        = "${var.sg_cluster}"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${var.tool_vpc_id}"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name              = "${var.sg_cluster}"
    Environment       = "${var.tag_env}"
    PONumber          = "${var.tag_po}"
    LMEntity          = "${var.tag_lm}"
    BU                = "${var.tag_bu}"
    Project           = "${var.tag_project}"
    ManagedBy         = "${var.tag_managed}"
    SecurityZone      = "${var.tag_sz}"
    Confidentiality   = "${var.tag_confidentiality}"
    TaggingVersion    = "${var.tag_version}"
    BusinessService   = "${var.tag_bs}"
    Terraform         = "true"
  }
}

resource "aws_security_group_rule" "cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.cluster.id}"
  source_security_group_id = "${aws_security_group.workers.id}" #SG dos workers
  to_port                  = 443
  type                     = "ingress"
}


resource "aws_security_group_rule" "cluster-ingress-workstation-https" {
  cidr_blocks       = ["213.30.18.1/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cluster.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "eks" {
  name     = "${var.cluster-name}"
  role_arn = "${aws_iam_role.cluster.arn}"
  enabled_cluster_log_types = ["api", "audit", "controllerManager", "authenticator"]

  vpc_config {
    security_group_ids = ["${aws_security_group.cluster.id}"]
    subnet_ids         = ["${var.cluster_subnet}"]
    
  }

  depends_on = [
    "aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy",
  ]
}

/*resource "aws_cloudwatch_log_group" "Cluster-loggroup" {
  name              = "/aws/eks/${var.cluster-name}/cluster"
  retention_in_days = 30
}*/