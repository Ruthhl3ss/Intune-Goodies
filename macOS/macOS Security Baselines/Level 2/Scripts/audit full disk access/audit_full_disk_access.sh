#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
#
# Script to Audit Applications with Full Disk Access on macOS
#
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
# - Add differentiation between system and user-installed apps
# - Integrate JSON output for cross-platform reporting
#
# Requirements:
# - MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Why use plist files instead of log files?
# -------------------------------------------------------------------------------------------------------------------------------
# Plist files offer structured, standardized data storage that integrates natively with macOS and MDM solutions like Intune.
# They allow for consistent parsing and structured reporting, making them ideal for environments where data integrity and
# easy retrieval are critical. Unlike log files, which are unstructured and prone to formatting inconsistencies,
# plist files maintain a predictable format that ensures compatibility with automated systems.
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
# Path to the TCC database and output plist
TCC_DB="/Library/Application Support/com.apple.TCC/TCC.db"
OUTPUT_FILE="/Library/Preferences/com.company.fulldiskaccess.plist"

# Step 1: Check if the TCC database exists
if [ ! -f "$TCC_DB" ]; then
    echo "TCC Database not found at $TCC_DB"
    exit 1
fi

# Step 2: Initialize an empty array to store apps with Full Disk Access
full_disk_apps=()

# Step 3: Query TCC.db for apps with Full Disk Access (auth_value = 2)
while IFS= read -r bundle_id; do
    echo "Processing bundle ID: $bundle_id"
    app_path=$(mdfind "kMDItemCFBundleIdentifier == '$bundle_id'" | head -n 1)

    if [ -n "$app_path" ]; then
        # Retrieve the display name of the application
        app_name=$(mdls -name kMDItemDisplayName -raw "$app_path")
        
        # Fallback methods in case display name isn't found
        if [ -z "$app_name" ]; then
            app_name=$(mdls -name kMDItemCFBundleName -raw "$app_path")
        fi
        if [ -z "$app_name" ]; then
            app_name=$(mdls -name kMDItemFSName -raw "$app_path")
        fi

        if [ -n "$app_name" ]; then
            echo "Found app: $app_name ($bundle_id)"
            full_disk_apps+=("$app_name ($bundle_id)")
        else
            echo "Found app path but no display name for $bundle_id"
            full_disk_apps+=("$bundle_id (No app display name found)")
        fi
    else
        echo "No app path found for $bundle_id"
        full_disk_apps+=("$bundle_id (No app path found)")
    fi
done < <(
    sqlite3 "$TCC_DB" "SELECT client FROM access WHERE service='kTCCServiceSystemPolicyAllFiles' AND auth_value=2;"
)

# Step 4: Debugging - Check if the output file exists before creating a new one
if ls -l "$OUTPUT_FILE"; then
    echo "DEBUG: File is visible to the script."
else
    echo "DEBUG: File is NOT visible to the script."
fi

# Step 5: Ensure the output file is freshly created on every run
if [ -f "$OUTPUT_FILE" ]; then
    echo "Existing plist found. Removing it to create a fresh one."
    rm "$OUTPUT_FILE"
else
    echo "File doesn't exist, will create: $OUTPUT_FILE"
fi

# Step 6: Create a new plist with the required structure
echo "Creating new plist file at $OUTPUT_FILE"
/usr/libexec/PlistBuddy -c "Add :FullDiskAccessApps array" "$OUTPUT_FILE"

# Step 7: Set permissions to ensure future detection and access
chmod 644 "$OUTPUT_FILE"
chown root:wheel "$OUTPUT_FILE"

# Confirm permissions to verify correct settings
ls -l "$OUTPUT_FILE"

# Step 8: Populate the plist with the Full Disk Access apps
for app in "${full_disk_apps[@]}"; do
    echo "Adding to plist: $app"
    /usr/libexec/PlistBuddy -c "Add :FullDiskAccessApps: string $app" "$OUTPUT_FILE"
done

# Step 9: Final confirmation message
echo "Full Disk Access apps have been written to $OUTPUT_FILE"
