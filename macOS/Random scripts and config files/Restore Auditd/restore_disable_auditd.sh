#!/bin/bash

################################################################################
# Script Name:   restore_disable_auditd.sh
# Description:   Restore macOS auditd by restoring audit_control settings,
#                from the audit_control.example file
# Author:        Oktay (for Intune deployment)
# Version:       1.0
# Created:       2025-02-17
# Updated:       2025-02-24
# Usage:         Deploy with Intune as a custom script
# Disclaimer:    Use at your own risk. This script modifies system settings.
#				 Use this script ONLY when things go wrong. It is NOT a guarantee but might help you restore original settings.
#
# WARNING:		 When you deploy this script using Intune, the script schedule is an important Setting.
#				 The device reboots when the policy applies. There is no recheck functionality yet.
#				 If you do not remove the device from the assignment when it is fixed, it will reboot on every script check-in conform your schedule
#				 If the Intune script is scheduled to run every 15 minutes, the device will reboot every 15 minutes.
################################################################################

# Enable strict error handling
set -euo pipefail

# Variables
AUDIT_CONTROL="/etc/security/audit_control"
AUDIT_CONTROL_BACKUP="/etc/security/audit_control.backup"
AUDIT_CONTROL_EXAMPLE="/etc/security/audit_control.example"
LOG_FILE="/Library/Logs/Microsoft/IntuneScripts/restore_disable_auditd.log"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Starting macOS audit restore process."

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    log "Error: This script must be run as root. Exiting."
    exit 1
fi

# Backup existing audit_control (if exists)
if [[ -f "$AUDIT_CONTROL" ]]; then
    log "Backing up existing audit_control to $AUDIT_CONTROL_BACKUP"
    cp "$AUDIT_CONTROL" "$AUDIT_CONTROL_BACKUP"
else
    log "No existing audit_control found. Skipping backup."
fi

# Restore audit_control from example
if [[ -f "$AUDIT_CONTROL_EXAMPLE" ]]; then
    log "Restoring audit_control from example."
    cp "$AUDIT_CONTROL_EXAMPLE" "$AUDIT_CONTROL"
else
    log "Error: audit_control.example not found at $AUDIT_CONTROL_EXAMPLE. Exiting."
    exit 1
fi

# Set correct permissions
log "Setting permissions for audit_control."
chown root:wheel "$AUDIT_CONTROL"
chmod 600 "$AUDIT_CONTROL"

# Disable auditd service
log "Disabling auditd service with launchctl."
launchctl disable system/com.apple.auditd

# Rebooting the system when policy is applied. this way you at least know the policy applied. 
# Since the user cannot login, the reboot has no impact. 
log "Rebooting the system to apply changes."
 sleep 5
shutdown -r now "Rebooting to apply audit settings."

exit 0
