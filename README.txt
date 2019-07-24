# This project has terraform scripts to create
# vpc
# security groups
# RDS instance with mysql
# An internet load balancer with ability with self signed certificate option on ssl on aws
# A web server
# Autoscaling groups
# s3 bucket template
# Cloud watch matrix alarm examples
#
#
# use for free aws account
# change aws_region
# ADD Nat gateway
# The settings are for test environment and not suitable for production
# Assign appropriate IPs for external network
# Change certificate_arn to correct value from aws.
# For self signed certificate for alb , modify the createcert.sh script and run certifcat/createcert.sh script before running terraform apply
# Disable the http aws_lb_listener listener. This was configured for test only
# Add any user data details to userdata_code/web.sh
#

# change   default     = "testapp-key-name" in variable.tf to a valid key name or create a new one by adding the following code 

# You can create the pem key here if not already created on aws.
# ssh-keygen -t rsa -b 2048
#resource "aws_key_pair" "deployerkey" {
#    key_name = "deployer_key"
#    public_key = "ssh-rsa AAAAABkc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1a;klyaer"
#}

# OR
#resource "aws_key_pair" "deployerkey" {
#    key_name = "deployer_key"
#    public_key = "${file("~/.ssh/testkey.pub")}"
#}
# RECOMMENDATIONS FOR PRODUCTION


#1. Increase backup retention e.g to 30 days
# Update variable.tf file
# Incease for production env
variable "rds_backup_retention_period"

#2. # Incease for production env
variable "rds_allocated_storage"

#3. Do not hard code password for database in script.

#4. Change "rds_storage_encryption" to true and assign correct rds_kms_key_id

#5. Enable storage autoscaling by setting

rds_max_allocated_storage

#6 Use auto scaling groups for ec2 instances

#7 Adopt good naming convention for NEs on AWS

#8 enable multi_az

