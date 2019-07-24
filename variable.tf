# NOTE: Update to meet environment requirement
# Project wide variable
variable "project_name" {
  description = "Project aws account is running on."
  default     = "testapp-production"
}
# Varibles for the Providers
# In this example, assign approriate role to an ec2 instance to run terraform from
# variable "aws_access_key" {}
# variable "aws_secret_key" {}
variable "aws_region" {
  description = "The AWS Region to run in."
  default     = "us-east-1"
}

# RDS Mysql Commondb variables

variable "rds_name" {
    description = "The database name"
    default = "testapp"
}

variable "rds_instance_id" {
    description = "The RDS instance identifier"
    default = "myapp-production-common-db"
}

variable "rds_availability_zone" {
    description = "The availability zone to place the instance into."
    default = "eu-west-1b"
}

variable "rds_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  default     = "gp2"
}

# Incease for production env
variable "rds_instance_class" {
  description = "RDS instance class"
  #default     = "db.t2.medium"
  #FOR Free demo environment setup use
  default     = "db.t2.micro"
}
variable "rds_engine" {
  description = "Database engine"
  default     = "mysql"
}
variable "rds_engine_version" {
  description = "Running mysql engine version. If left blank, latest engine will be used."
  default     = "5.6.41"
}

# Incease for production env, 20GB free
variable "rds_allocated_storage" {
  description = "Storage size in gb"
  default     = "20"
}

# Incease for production env
variable "rds_backup_retention_period" {
  description = "How many days to retain backups."
  default     = "7"
}

variable "rds_backup_window" {
    description = "The daily time range (in UTC) during which automated backups are created, if enabled."
    default = "09:00-10:00"
}

variable "rds_maintenance_window" {
    description = "The period to carry out maintenance"
    default = "Sat:11:00-Sat:12:00"
}

variable "rds_deletion_protection" {
    description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true"
    default = "false"
}

variable "rds_publicly_accessible" {
  description = "If true, the database can be connected via the internet."
  default     = "true"
}

## Create alternative method of authentication rather than hardcoding credentials.
variable "rds_username" {
  description = "Username for the master DB user."
  default     = "testdbmaster"
}

variable "rds_password" {
  description = "Password for the master DB user."
  default     = "dontuseinprod1"
}

# change for production
variable "rds_storage_encryption" {
    description = "Specifies whether the DB instance is encrypted"
    default = "false"
}

### Update with real key
variable "rds_kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default     = "a0dssfaasdfe5-1cbbbd-44442-92e2-3180gcdgd562687f"
}
# to enable db storage autoscaling

# Add to variable.tf
variable "rds_max_allocated_storage" {
  description = "Enable storage auto-scaling with this. Size in gb"
  default     = "100"
}

# Ec2 /Autoscaling Groups Variables

# change ssh CIDR to your host public ip or openvpn for example or bastion station

variable "ssh_cidr_web_server" {
  description = "CIDR block to access web server via ssh"
  default     = "0.0.0.0/0"
}
variable "web_server_instance_type"{
  description = "Web server instance type"
  #default     = "t3.medium"
  default     = "t2.micro"
}

variable "user_data_for_webserver" {
  description = "Boot strap script to install application on web server"
  default     = "./userdata_code/web.sh"
}

variable "pem_file_webservers" {
  description = "Pem key to be able to access webserver after launch"
  default     = "test-acc-only"
}

# VPC Variables
variable "vpc_cird_block" {
  description = "Commondb VPC CIDR block "
  default     = "10.10.0.0/16"
}

variable "open_vpn" {
  description = "Open VPN IP address "
  default     = "10.10.128.71/32"
}
# vpc public subnets
variable "vpc_public_subnet1_cird_block" {
  description = "Public subnet 1 for ... "
  default     = "10.10.128.0/24"
}
variable "vpc_public_subnet2_cird_block" {
  description = "Public subnet 2 for ..."
  default     = "10.10.160.0/24"
}
variable "vpc_public_subnet3_cird_block" {
  description = "Public subnet 3 for ..."
  default     = "10.10.176.0/24"
}
# vpc private subnets
variable "vpc_private_subnet1_cird_block" {
  description = "Private subnet 1 for ..."
  default     = "10.10.0.0/20"
}
variable "vpc_private_subnet2_cird_block" {
  description = "Private subnet 2 for ..."
  default     = "10.10.16.0/20"
}
variable "vpc_private_subnet3_cird_block" {
  description = "Private subnet 3 for ..."
  default     = "10.10.32.0/20"
}

