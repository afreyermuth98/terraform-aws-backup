variable "region" {
  type        = string
  description = "AWS Account region"
  default     = "eu-west-3"
}

variable "deletion_time" {
  type        = string
  description = "Number of days to keep backup in vault"
  default     = "35"
}

variable "backup_key" {
  type        = string
  description = "Backup key to select which resources to backup"
  default     = "backup"
}

variable "backup_value" {
  type        = string
  description = "Backup value to select which resources to backup"
  default     = "true"
}

# variable "cross_account_id" {
#     type = string
#     description = "Account where you want to perform cross-account backups"
#     default= ""
# }