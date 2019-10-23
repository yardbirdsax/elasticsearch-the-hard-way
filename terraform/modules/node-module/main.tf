data template_cloudinit_config "userData" {
  count = var.nodeCount
  part {
    content = <<EOF
#cloud-config
---
hostname: "${var.instanceName}-${count.index}"
EOF
    content_type = "text/cloud-config"
  } 
}

resource aws_instance "instance" {
  
  ami = var.amiId
  instance_type = "t2.small"
  tags = {
    Name = "${var.instanceName}-${count.index}"
  }
  count = var.nodeCount
  subnet_id = var.subnetId
  vpc_security_group_ids = [var.securityGroupId]
  key_name = var.keyName
  user_data = data.template_cloudinit_config.userData[count.index].rendered
  #user_data = data.template_cloudinit_config.esInit[count.index].rendered
}

resource aws_eip "elasticIp" {
  vpc = true
  count = var.nodeCount
  instance = aws_instance.instance[count.index].id
}

output "dnsNames" {
  value = join(",", aws_eip.elasticIp.*.public_dns)
}