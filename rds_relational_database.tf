 resource "aws_db_instance" "crypto_db" {
   allocated_storage                     = 20
   password                              = "password"
   auto_minor_version_upgrade            = true
   availability_zone                     = "sa-east-1a"
   backup_retention_period               = 1
   backup_window                         = "01:18-01:48"
   ca_cert_identifier                    = "rds-ca-2019"
   copy_tags_to_snapshot                 = true
   db_subnet_group_name                  = aws_db_subnet_group.submet_group_rds.id
   delete_automated_backups              = true
   engine                                = "postgres"
   engine_version                        = "16.1"
   identifier                            = "db"
   instance_class                        = "db.t3.micro"
   license_model                         = "postgresql-license"
   max_allocated_storage                 = 1000
   option_group_name                     = "default:postgres-16"
   parameter_group_name                  = aws_db_parameter_group.default_postgres16.id
   performance_insights_enabled          = true
   performance_insights_retention_period = 7
   port                                  = 5432
   publicly_accessible                   = true
   skip_final_snapshot                   = true
   storage_encrypted                     = true
   storage_type                          = "gp2"
   username                              = "postgres"
   vpc_security_group_ids                = [aws_security_group.sg_rds.id]
 }

 resource "aws_db_parameter_group" "default_postgres16" {
   description = "Default parameter group for postgres15"
   family      = "postgres16"
   name        = "default.postgres16"
 }

 resource "aws_db_subnet_group" "submet_group_rds" {
   description = "Created from the RDS"
   name        = "default-vpc-0c1ff118d1955a61d"
   subnet_ids  = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]
 }
