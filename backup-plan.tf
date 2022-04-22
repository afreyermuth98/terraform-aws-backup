resource "aws_backup_plan" "backup-plan" {
  name = "demo-backup-plan"

  rule {
    rule_name         = "demo__backup_rule"
    target_vault_name = aws_backup_vault.default.name
    schedule          = "cron(0 5 * * ? *)"

    lifecycle {
      delete_after = var.deletion_time
    }
    enable_continuous_backup = true
  }
}

resource "aws_backup_selection" "backup-selection" {
  iam_role_arn = aws_iam_role.aws-backup-service-role.arn
  name         = "backup_resources"
  plan_id      = aws_backup_plan.backup-plan.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.backup_value
    value = var.backup_value
  }
}