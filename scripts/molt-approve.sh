#!/usr/bin/env bash
# molbot-approve: Utility to auto-approve all pending device requests
echo "🔎 Checking for pending device requests..."
# Using full path to moltbot ensure it works regardless of shell
MOLTBOT="/home/node/.npm-global/bin/moltbot"
IDS=$($MOLTBOT devices list --json | jq -r '.pending[].id' 2>/dev/null)

if [ -z "$IDS" ]; then
  echo "✅ No pending requests found."
  exit 0
fi

for ID in $IDS; do
  echo "🚀 Approving request: $ID"
  $MOLTBOT devices approve "$ID"
done
