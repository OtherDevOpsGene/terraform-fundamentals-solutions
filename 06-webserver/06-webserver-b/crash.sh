#! /bin/bash

aws ec2 describe-instances \
  --filters "Name=availability-zone,Values=us-east-2a" \
            "Name=tag:Environment,Values=prod" \
            "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].[InstanceId]" \
  --output text | \
xargs --no-run-if-empty aws ec2 stop-instances --instance-ids
