resource "aws_backup_vault" "default" {
  name        = "demo-backup-vault"
  kms_key_arn = aws_kms_key.vault_kms_key.arn
}
