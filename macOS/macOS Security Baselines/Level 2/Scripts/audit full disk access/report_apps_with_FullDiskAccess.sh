#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# WARNING: This script works best if you deploy both the audit and report scripts.
# 1 - audit_apps_with_FullDiskAccess.sh
# 2 - report_apps_with_FullDiskAccess.sh
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
# 09-02-2025 - Oktay Sari - Script version 1.0
#
# ROADMAP/WISHLIST:
# - Add JSON output support for more flexible reporting
#
# Requirements:
# - MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------

# Define variables
OUTPUT_FILE="/Library/Preferences/com.company.fulldiskaccess.plist"

# Check if the output plist exists and read the Full Disk Access apps
if [ -f "$OUTPUT_FILE" ]; then
    full_disk_apps=$(defaults read "$OUTPUT_FILE" FullDiskAccessApps)
    echo "Full Disk Access Apps: $full_disk_apps"
else
    echo "No apps found with Full Disk Access."
fi