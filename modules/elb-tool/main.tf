resource "aws_elb" "elb-tool" {
  name            = "${var.cluster-name}elb-tooling"
  subnets         = ["${var.cluster_subnet}"]
   listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"

  }

  health_check {
    healthy_threshold = 10
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/health"
    interval = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 300

  
    tags {
    Name              = "${var.tag_name}"
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