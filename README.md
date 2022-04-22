# Terraform AWS Backup

This project contains base IaC to deploy prerequisites to use AWS Backup. It contains a backup policy to perform cross acount and cross region backup on authorized services with `backup: true` tag enabled.


## What to do

* You can custom cron expression in the [backup-policy.tpl](./backup-policy.tpl) file. Actual is hourly
* You can use [backup-policy-cross.tpl](./backup-policy-cross.tpl) which is a more complex policy to use cross account and cross region but you need to deploy prerequisites on region and account wanted.