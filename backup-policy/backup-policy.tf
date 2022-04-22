
resource "aws_organizations_policy" "backup_policy" {
  name        = "demo-ippon-backup-policy"
  type        = "BACKUP_POLICY"
  description = "Demo organization backup policy"
  content = templatefile(
    "./backup-policy.tpl",
    {
      paris_vault_name               = "Default"
      frankfurt_vault_name           = "Default"
      paris_cross_account_vault_name = "Default"

      paris_vault_lifecycle_delete_after_days               = 35
      paris_cross_account_vault_lifecycle_delete_after_days = 35
      frankfurt_vault_lifecycle_delete_after_days           = 35

      enabled_continuous_backup = "true"

    # If you want to use cross account backup, uncomment next line
    #   cross_account_id = "${var.cross_account_id}"
    }
  )
}

data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

resource "aws_organizations_policy_attachment" "backup_policy" {
  policy_id = aws_organizations_policy.backup_policy_main.id
  target_id = local.account_id
}
