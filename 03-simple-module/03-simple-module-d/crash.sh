#! /bin/bash

aws ec2 describe-instances \
  --filters "Name=availability-zone,Values=us-east-2a" \
            "Name=tag:Lesson,Values=lesson-03" \
            "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].[InstanceId]" \
  --output text | \
xargs --no-run-if-empty aws ec2 stop-instances --instance-ids
