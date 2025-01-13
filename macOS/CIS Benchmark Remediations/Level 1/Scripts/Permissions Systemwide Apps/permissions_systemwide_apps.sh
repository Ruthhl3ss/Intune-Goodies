#!/bin/zsh
# -------------------------------------------------------------------------------------------------------------------------------
# Script to ensure appropriate permissions for system-wide applications
# CIS Benchmark Level 1 - 5.1.5 Ensure Appropriate Permissions Are Enabled for SystemWide Applications
# -------------------------------------------------------------------------------------------------------------------------------
#
# remove the previous line (set -x) if you want to run the script line by line.
# in terminal type: bash -x scriptname
#
# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.

# EXTRA NOTES:
# This script removes the world-writable permissions from applications to improve security. However, this change may affect how
# certain applications function, especially if they rely on being world-writable for updates or shared usage. Different environments
# may have varying levels of tolerance for these changes, so it is important to evaluate the potential impact carefully.
# Avoid applying this script globally if mission-critical applications are improperly configured, as it could disrupt essential
# operations or cause downtime. Always test the script in a controlled environment before using it on production systems.
# Review each application individually to ensure that these changes will not negatively affect its operation. This script is
# provided "as is," and users assume all responsibility for its use.
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
# This script is by no means perfect. I'm also not an expert bash programmer. 
# If you think you have a good idea to further enhance this script, then please reach out.
#
# SCRIPT VERSION/HISTORY:
# 21-12-2024 - Oktay Sari - Script version 1.0
#
# ROADMAP/WISHLIST:
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
appname="RemediatePermissions"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"
APPLICATIONS_DIR="/System/Volumes/Data/Applications"
EXCLUDED_APP="Xcode.app"

# Check if the log directory has been created
if [ -d "$logandmetadir" ]; then
    echo "$(date) | Log directory already exists - $logandmetadir"
else
    echo "$(date) | Creating log directory - $logandmetadir"
    mkdir -p "$logandmetadir"
fi

# Start logging
exec &> >(tee -a "$log")

# Define the function to remediate permissions
RemediatePermissions() {
    echo "$(date) | Checking for non-conforming applications..."
    non_conforming_apps=$(sudo find "$APPLICATIONS_DIR" -iname "*.app" -type d -perm -2 | grep -v "$EXCLUDED_APP")

    if [[ -z "$non_conforming_apps" ]]; then
        echo "$(date) | No non-conforming applications found."
        exit 0
    else
        echo "$(date) | Found the following non-conforming applications:"
        echo "$non_conforming_apps"
    fi

    echo "$(date) | Remediating permissions for non-conforming applications..."
    # Process each app separately
    echo "$non_conforming_apps" | while read -r app; do
        if [[ -d "$app" ]]; then
            echo "$(date) | Correcting permissions for: $app"
            sudo chmod -R o-w "$app"
            if [[ $? -eq 0 ]]; then
                echo "$(date) | Permissions corrected for: $app"
            else
                echo "$(date) | Failed to correct permissions for: $app"
            fi
        else
            echo "$(date) | Warning: Application path does not exist: $app"
        fi
    done

    echo "$(date) | Remediation complete."
}

# Begin Script Body
echo ""
echo " -----------------------------------------------------------"
echo " $(date) | Starting script $appname"
echo " -----------------------------------------------------------"
echo ""

# Run the function
RemediatePermissions