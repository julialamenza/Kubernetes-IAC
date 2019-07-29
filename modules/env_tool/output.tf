################################################# Env Tool Output #####################################
output "tool_vpc_id" {
  description = "ID of the VPC"
  value       = "${aws_vpc.vpc_tool.id}"
}

output "subnet_priv1_id" {
  description = "Subnet priv1 ID"
  value       = "${aws_subnet.SubNet-priv1.id}"
}

output "subnet_public-NAT_id" {
  description = "Subnet priv1 ID"
  value       = "${aws_subnet.SubNet-public-NAT.id}"
}

output "subnet_priv_WIN_id" {
  description = "Subnet priv1 ID"
  value       = "${aws_subnet.SubNet-priv_WIN.id}"
}

output "subnet_priv2_id" {
  description = "Subnet priv1 ID"
  value       = "${aws_subnet.SubNet-priv2.id}"
}

output "subnet_priv_tool1_id" {
  description = "Subnet priv1 ID"
  value       = "${aws_subnet.SubNet-priv_tool1.id}"
}
output "subnet_priv_tool2_id" {
  description = "Subnet priv1 ID"
  value       = "${aws_subnet.SubNet-priv_tool2.id}"
}
output "subnet_priv_tool3_id" {
  description = "Subnet priv1 ID"
  value       = "${aws_subnet.SubNet-priv_tool3.id}"
}

output "automation_sg_id" {
  description = "Automation security group id"
  value       = "${aws_security_group.automation.id}"
}
/*
output "dmz_internet_gateway_id" {
  value = "${aws_internet_gateway.dmz_internet_gateway.id}"
}
*/

output "dmz_eip_id" {
  value = "${aws_eip.dmz_nat_eip.id}"
}
output "tool_igw_id" {
  value = "${aws_internet_gateway.tool_igw.id}"
}

##########################################################################################################
