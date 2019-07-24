resource "aws_launch_configuration" "asg_temp_for_webserver" {
  #name   = "AutoScaleGrp-webserver-1"
  name_prefix     = "testapp-asg"
  # to use parker image, generate the image and update the ami id here
  image_id = "ami-03fd2027f09074770"
  # image_id = "ami-0438dd8314dde7593"
  # to use latest amazon linux 2 ami
  #image_id      = "${data.aws_ami.amazon-linux-2.id}"
  # to use a known ami
  #image_id      = "ami-0b898040803850657"
  instance_type = "${var.web_server_instance_type}"
  user_data = "${file("${var.user_data_for_webserver}")}"
  security_groups = ["${aws_security_group.testapp-instance-sg.id}"]
  key_name = "${var.pem_file_webservers}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "25"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }

}

# For Ubuntu ami
#data "aws_ami" "ubuntu" {
#  most_recent = "true"
# owners = ["099720109477"]
#  filter
#  {
#  name = "name"
#  values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
#  }
# filter
# {
#  name = "virtualization-type"
#  values = ["hvm"]
# }
#}

#output "aws_ami" "ubuntu"
#{
#  value = "${data.aws_ami.ubuntu.id}"
#}


data "aws_ami" "amazon-linux-2" {
 most_recent = true
 #owners = ["amazon"]
 owners = ["137112412989"]

 filter {
    name   = "architecture"
    values = ["x86_64"]
  }
 filter {
    name   = "image-type"
    values = ["machine"]
  }
 filter {
    name   = "is-public"
    values = ["true"]
  }
 filter {
    name   = "state"
    values = ["available"]
  }
 name_regex = "^amzn2-ami-hvm-2.0*"
}


