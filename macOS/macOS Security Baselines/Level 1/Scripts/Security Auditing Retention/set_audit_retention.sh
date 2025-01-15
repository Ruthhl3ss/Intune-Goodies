#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Script to Esnsure the Sudo Timeout Period Is Set to Zero
# CIS Benchmark Level 1 - 5.4 Ensure the Sudo Timeout Period Is Set to Zero
# -------------------------------------------------------------------------------------------------------------------------------
#
# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
# -------------------------------------------------------------------------------------------------------------------------------
#
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
#
# -------------------------------------------------------------------------------------------------------------------------------
# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/
#
# NOTE:
# This script is by no means perfect. I'm not an expert bash programmer. 
# If you think you have a good idea to further enhance this script, then please reach out.
#
# SCRIPT VERSION/HISTORY:
# 07-01-2025 - Oktay Sari - Script version 1.0
#
# ROADMAP/WISHLIST:
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables

# Define variables
appname="EnsureAuditRetention"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"

# Check if the log directory has been created
if [ -d "$logandmetadir" ]; then
    # Already created
    echo "$(date) | Log directory already exists - $logandmetadir"
else
    # Creating log directory
    echo "$(date) | Creating log directory - $logandmetadir"
    mkdir -p $logandmetadir
fi

# Start logging
exec &> >(tee -a "$log")

# Begin Script Body
echo ""
echo "##############################################################"
echo "# $(date) | Starting running of script $appname"
echo "##############################################################"
echo ""

# Path to the audit control configuration file
AUDIT_CONTROL_FILE="/etc/security/audit_control"

# Desired setting (minimum 60 days OR 5GB)
DESIRED_SETTING="expire-after:60d OR 5G"

# Function to add or update the expire-after setting
function update_audit_control {
    # Check if the expire-after setting is correctly configured
    CURRENT_SETTING=$(grep "^expire-after" $AUDIT_CONTROL_FILE)

    if [[ -n "$CURRENT_SETTING" ]]; then
        # Setting exists, update it
        sudo sed -i.bak "s|^expire-after.*|$DESIRED_SETTING|" $AUDIT_CONTROL_FILE
        echo "$(date) | Updated audit retention setting to $DESIRED_SETTING."
    else
        # Setting does not exist, add it
        echo "$DESIRED_SETTING" | sudo tee -a $AUDIT_CONTROL_FILE > /dev/null
        echo "$(date) | Added audit retention setting: $DESIRED_SETTING."
    fi
}

# Check and update the audit retention settings
update_audit_control

echo "$(date) | Script completed. Audit retention setting checked and updated as necessary."
