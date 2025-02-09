#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Script to Ensure 'Show Location Icon in Control Center when System Services Request Your Location' Is Enabled
# CIS Benchmark Level 2 - 2.6.1.2 Ensure 'Show Location Icon in Control Center when System Services Request Your Location' Is Enabled
# -------------------------------------------------------------------------------------------------------------------------------
#
# -------------------------------------------------------------------------------------------------------------------------------
# WARNING: This script only works if you deploy it as a collection of scripts. You will need 3 scripts for this to work:
# 1- EnableLocationServiceIcon (optional but recommended)
# 2- audit_apps_using_Locationservices.sh
# 3- report_apps_using_Locationservices
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
# 06-02-2025 - Oktay Sari - Script version 1.0
#
# ROADMAP/WISHLIST:
#
# Requirements:
# MDM to deploy script
# Why use plist files instead of log files?
# -------------------------------------------------------------------------------------------------------------------------------
# Plist files offer structured, standardized data storage that integrates natively with macOS and MDM solutions like Intune.
# They allow for consistent parsing and structured reporting, making them ideal for environments where data integrity and
# easy retrieval are critical. Unlike log files, which are unstructured and prone to formatting inconsistencies,
# plist files maintain a predictable format that ensures compatibility with automated systems.
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
appname="EnableLocationIcon"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"
plist_path="/Library/Preferences/com.apple.locationmenu.plist"

# Check if the log directory has been created
if [ -d "$logandmetadir" ]; then
    echo "$(date) | Log directory already exists - $logandmetadir"
else
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

# Function to enable 'Show Location Icon for System Services'
function enable_location_icon {
    echo "$(date) | Checking if $plist_path exists."

    if [ -f "$plist_path" ]; then
        echo "$(date) | $plist_path exists. Checking current setting."
        current_setting=$(/usr/bin/defaults read "$plist_path" ShowSystemServices 2>/dev/null)

        if [[ "$current_setting" == "1" ]]; then
            echo "$(date) | 'Show Location Icon' is already enabled. No changes made."
        else
            echo "$(date) | 'Show Location Icon' is disabled or not set. Enabling now."
            /usr/bin/defaults write "$plist_path" ShowSystemServices -bool true
            chown root:wheel "$plist_path"
            chmod 644 "$plist_path"

            # Verify the change
            verify_setting=$(/usr/bin/defaults read "$plist_path" ShowSystemServices)
            if [[ "$verify_setting" == "1" ]]; then
                echo "$(date) | Successfully enabled 'Show Location Icon'."
            else
                echo "$(date) | Failed to enable 'Show Location Icon'. Please check manually."
            fi
        fi
    else
        echo "$(date) | $plist_path does not exist. Creating and enabling setting."
        /usr/bin/defaults write "$plist_path" ShowSystemServices -bool true
        chown root:wheel "$plist_path"
        chmod 644 "$plist_path"

        # Verify the change
        verify_setting=$(/usr/bin/defaults read "$plist_path" ShowSystemServices)
        if [[ "$verify_setting" == "1" ]]; then
            echo "$(date) | Successfully created $plist_path and enabled 'Show Location Icon'."
        else
            echo "$(date) | Failed to create $plist_path or enable 'Show Location Icon'. Please check manually."
        fi
    fi
}

# Execute the function
enable_location_icon

echo "$(date) | Script completed. 'Show Location Icon' setting has been applied."
