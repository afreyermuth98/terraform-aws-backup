data "aws_iam_policy_document" "aws_backup_service_assume_role_policy" {
  statement {
    sid     = "AssumeServiceRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "aws_backup_service_policy" {
  arn  = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}


data "aws_iam_policy" "aws_restore_service_policy" {
  arn  = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

data "aws_iam_policy" "aws_backup_s3_service_policy" {
  arn  = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
}

data "aws_iam_policy" "aws_restore_s3_service_policy" {
  arn  = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Restore"
}

resource "aws_iam_role" "aws_backup_service_role" {
  name               = "backup-role"
  description        = "Allows AWS Backup to access AWS resources on your behalf based on the permissions you define."
  assume_role_policy = data.aws_iam_policy_document.aws_backup_service_assume_role_policy.json
}

resource "aws_iam_role_policy" "backup_service_aws_backup_role_policy" {
  name   = "AWSBackupServiceRolePolicyForBackup"
  policy = data.aws_iam_policy.aws_backup_service_policy.policy
  role   = aws_iam_role.aws_backup_service_role.name
}

resource "aws_iam_role_policy" "restore_service_aws_backup_role_policy" {
  name   = "AWSBackupServiceRolePolicyForRestores"
  policy = data.aws_iam_policy.aws_restore_service_policy.policy
  role   = aws_iam_role.aws_backup_service_role.name
}

resource "aws_iam_role_policy" "backup_service_aws_backup_s3_role_policy" {
  name   = "AWSBackupServiceRolePolicyForS3Backup"
  policy = data.aws_iam_policy.aws_backup_s3_service_policy.policy
  role   = aws_iam_role.aws_backup_service_role.name
}

resource "aws_iam_role_policy" "restore_service_aws_restore_s3_role_policy" {
  name   = "AWSBackupServiceRolePolicyForS3Restore"
  policy = data.aws_iam_policy.aws_restore_s3_service_policy.policy
  role   = aws_iam_role.aws_backup_service_role.name
}
