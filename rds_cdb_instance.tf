resource "aws_db_instance" "testapp-rds-prod" {
  identifier = "${var.rds_instance_id}"
  name = "${var.rds_name}"
  allocated_storage = "${var.rds_allocated_storage}"
  storage_type = "${var.rds_storage_type}"
  engine = "${var.rds_engine}"
  engine_version = "${var.rds_engine_version}"
  instance_class = "${var.rds_instance_class}"
  backup_retention_period = "${var.rds_backup_retention_period}"
  publicly_accessible = "${var.rds_publicly_accessible}"
  username = "${var.rds_username}"
  password = "${var.rds_password}"
  vpc_security_group_ids = ["${aws_security_group.testapp-mysql-in.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.name}"
  copy_tags_to_snapshot = "false"
  #availability_zone = "${var.rds_availability_zone}"
  #availability_zone = "${data.availability_zone.available.names[1]}
  multi_az = "false"
  #
  backup_window = "${var.rds_backup_window}"
  maintenance_window = "${var.rds_maintenance_window}"

  storage_encrypted = "${var.rds_storage_encryption}"
  # some random key, obtain real key on aws

  #kms_key_id = "${var.rds_kms_key_id}"
  # Add to rds_testapp_instance.tf
  # enable storage autoscaling
  #max_allocated_storage   = "${var.rds_max_allocated_storage}"

  # Attached parameter group
  # parameter_group_name = "default:mysql-5-6" or use current configuration
  #parameter_group_name = "testapp-log-bin-trust-function-creators"

  # or set parameters in tf file and attach to instance.
  #parameter_group_name = "${aws_db_parameter_group.testdb-parameter-group.name}"


  # not for production
  #snapshot_identifier = "snapshotname01"
  # set to true for none production env
  skip_final_snapshot = true

  tags = {
      workload-type = "production"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name          = "${var.project_name}_rds_subnet_group"
    description   = "Allowed subnets for RDS cluster instances"
    subnet_ids    = [
      "${aws_subnet.private_subnet_1.id}",
      "${aws_subnet.private_subnet_2.id}",
      "${aws_subnet.private_subnet_3.id}"
    ]
}

output "testdb_rds_prod_endpoint" {
  value = "${aws_db_instance.testapp-rds-prod.endpoint}"
  description = "Mysql RDS endpoint"
}

