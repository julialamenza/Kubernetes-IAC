output "elb_dns_name" {
  value = "${aws_elb.elb-tool.dns_name}"
}
output "elb_zone_id" {
  value = "${aws_elb.elb-tool.zone_id}"
}
output "elb_id" {
  value = "${aws_elb.elb-tool.id}"
}
output "elb_name" {
  value = "${aws_elb.elb-tool.name}"
}
output "elb_arn" {
  value = "${aws_elb.elb-tool.arn}"
}