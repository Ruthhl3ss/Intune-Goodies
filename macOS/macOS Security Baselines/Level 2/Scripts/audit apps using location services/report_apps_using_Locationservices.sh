#!/bin/bash
#set -x
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
# -------------------------------------------------------------------------------------------------------------------------------

# Define variables

OUTPUT_FILE="/Library/Preferences/com.company.locationapps.plist"

if [ -f "$OUTPUT_FILE" ]; then
    authorized_apps=$(defaults read "$OUTPUT_FILE" AuthorizedApps)
    echo "Authorized Apps: $authorized_apps"
else
    echo "No apps found using Location Services."
fi
