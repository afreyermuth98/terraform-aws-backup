{
    "plans": {
        "demo-backup-plan": {
            "regions": {
                "@@assign": [
                    "eu-west-3"
                ]
            },
            "rules": {
                "demo-backup-rule": {
                    "schedule_expression": {
                        "@@assign": "cron(0 5 ? * * *)"
                    },
                    "start_backup_window_minutes": {
                        "@@assign": "60"
                    },
                    "complete_backup_window_minutes": {
                        "@@assign": "180"
                    },
                    "lifecycle": {
                        "delete_after_days": {
                            "@@assign": "${deletion_time}"
                        }
                    },
                    "target_backup_vault_name": {
                        "@@assign": "$vault_name"
                    },
                    "enable_continuous_backup": {
                        "@@assign": "${enable_continuous_backup}"
                    }
                }
            },
            "backup_plan_tags": {
                "owner": {
                    "tag_key": {
                        "@@assign": "owner"
                    },
                    "tag_value": {
                        "@@assign": "$owner"
                    }
                }
            },
            "selections": {
                "tags": {
                    "backup-selection": {
                        "iam_role_arn": {
                            "@@assign": "arn:aws:iam::$account:role/service-role/backup-role"
                        },
                        "tag_key": {
                            "@@assign": "backup"
                        },
                        "tag_value": {
                            "@@assign": [
                                "true"
                            ]
                        }
                    }
                }
            }
        }
    }
}