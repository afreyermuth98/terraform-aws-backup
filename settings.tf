resource "aws_backup_region_settings" "backup_region_settings" {
  resource_type_opt_in_preference = {
    "Aurora"          = true
    "DocumentDB"      = false
    "DynamoDB"        = true
    "EBS"             = true
    "EC2"             = true
    "EFS"             = true
    "FSx"             = true
    "Neptune"         = false
    "RDS"             = true
    "S3"              = true
    "Storage Gateway" = true
    "VirtualMachine"  = true
  }
}