data "aws_iam_policy_document" "aws-backup-service-assume-role-policy" {
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

data "aws_iam_policy" "aws-backup-service-policy" {
  name = "AWSBackupServiceRolePolicyForBackup"
  arn  = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

data "aws_iam_policy" "aws-restore-service-policy" {
  name = "AWSBackupServiceRolePolicyForRestores"
  arn  = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

data "aws_iam_policy" "aws-backup-s3-service-policy" {
  name = "AWSBackupServiceRolePolicyForS3Backup"
  arn  = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
}

data "aws_iam_policy" "aws-restore-s3-service-policy" {
  name = "AWSBackupServiceRolePolicyForS3Restore"
  arn  = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Restore"
}

resource "aws_iam_role" "aws-backup-service-role" {
  name               = "backup-role"
  description        = "Allows AWS Backup to access AWS resources on your behalf based on the permissions you define."
  assume_role_policy = data.aws_iam_policy_document.aws-backup-service-assume-role-policy.json
}

resource "aws_iam_role_policy" "backup-service-aws-backup-role-policy" {
  name   = "AWSBackupServiceRolePolicyForBackup"
  policy = data.aws_iam_policy.aws-backup-service-policy.policy
  role   = aws_iam_role.aws-backup-service-role.name
}

resource "aws_iam_role_policy" "restore-service-aws-backup-role-policy" {
  name   = "AWSBackupServiceRolePolicyForRestores"
  policy = data.aws_iam_policy.aws-restore-service-policy.policy
  role   = aws_iam_role.aws-backup-service-role.name
}

resource "aws_iam_role_policy" "backup-service-aws-backup-s3-role-policy" {
  name   = "AWSBackupServiceRolePolicyForS3Backup"
  policy = data.aws_iam_policy.aws-backup-s3-service-policy.policy
  role   = aws_iam_role.aws-backup-service-role.name
}

resource "aws_iam_role_policy" "restore-service-aws-restore-s3-role-policy" {
  name   = "AWSBackupServiceRolePolicyForS3Restore"
  policy = data.aws_iam_policy.aws-restore-s3-service-policy.policy
  role   = aws_iam_role.aws-backup-service-role.name
}
