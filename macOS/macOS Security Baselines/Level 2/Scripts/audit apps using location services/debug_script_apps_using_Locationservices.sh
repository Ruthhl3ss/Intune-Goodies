#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Script to Ensure 'Show Location Icon in Control Center when System Services Request Your Location' Is Enabled
# CIS Benchmark Level 2 - 2.6.1.2 Ensure 'Show Location Icon in Control Center when System Services Request Your Location' Is Enabled
# -------------------------------------------------------------------------------------------------------------------------------
#
# -------------------------------------------------------------------------------------------------------------------------------
# WARNING: This script only used for TESTING purposes locally and DOES NOT NEED TO BE DEPLOYED to devices using Intune.
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


# Path to the Location Services database and temporary XML file
LS_DB="/var/db/locationd/clients.plist"
XML_DB="/tmp/clients.xml"

# Check if the plist exists
if [ ! -f "$LS_DB" ]; then
    echo "Location Services Database not found at $LS_DB"
    exit 1
fi

# Convert binary plist to XML
plutil -convert xml1 -o "$XML_DB" "$LS_DB"

# Check if conversion was successful
if [ ! -f "$XML_DB" ]; then
    echo "Failed to convert binary plist to XML."
    exit 1
fi

echo "Applications using Location Services (Authorized == true):"

# Filter out non-UTF-8 characters and parse authorized apps
/usr/libexec/PlistBuddy -c "Print" "$XML_DB" | iconv -f UTF-8 -t UTF-8//IGNORE | 
awk '
    BEGIN { authorized = 0; bundle_id = "" }
    /BundleId =/ { bundle_id = $3 }
    /Authorized = true/ {
        if (bundle_id != "") {
            print bundle_id
            bundle_id = ""
        } else {
            authorized = 1
        }
    }
    /^[^ ]/ {
        if (authorized && bundle_id != "") {
            print bundle_id
            authorized = 0
            bundle_id = ""
        }
    }
' | while read bundle_id; do
    # Attempt to get the app name from the bundle ID
    app_path=$(mdfind "kMDItemCFBundleIdentifier == '$bundle_id'" | head -n 1)
    if [ -n "$app_path" ]; then
        app_name=$(mdls -name kMDItemDisplayName -raw "$app_path")
        if [ -z "$app_name" ]; then
            app_name=$(mdls -name kMDItemCFBundleName -raw "$app_path")
        fi
        if [ -z "$app_name" ]; then
            app_name=$(mdls -name kMDItemFSName -raw "$app_path")
        fi

        if [ -n "$app_name" ]; then
            echo "$app_name ($bundle_id)"
        else
            executable=$(mdls -name kMDItemExecutable -raw "$app_path")
            echo "${executable:-$bundle_id} ($bundle_id)"
        fi
    else
        echo "$bundle_id (Note: No app path found or app name found for this app)"
    fi
    done
