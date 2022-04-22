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
                    "copy_actions": {
                        "arn:aws:backup:eu-west-1:${account_id}:backup-vault:cross-region": {
                            "target_backup_vault_arn": {
                                "@@assign": "arn:aws:backup:eu-west-1:${account_id}:backup-vault:${cross_region_vault_name}"
                            },
                            "lifecycle": {
                                "delete_after_days": {
                                    "@@assign": "${cross_region_deletion_time}"
                                }
                            }
                        },
                        "arn:aws:backup:eu-west-3:${cross_account_id}:backup-vault:cross-account": {
                            "target_backup_vault_arn": {
                                "@@assign": "arn:aws:backup:eu-west-3:${cross_account_id}:backup-vault:${cross_account_vault_name}"
                            },
                            "lifecycle": {
                                "delete_after_days": {
                                    "@@assign": "${cross_account_deletion_time}"
                                }
                            }
                        }
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