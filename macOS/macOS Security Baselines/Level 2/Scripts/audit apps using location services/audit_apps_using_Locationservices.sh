#!/bin/bash
#set -x
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
# Path to the Location Services database and temporary XML file
LS_DB="/var/db/locationd/clients.plist"
XML_DB="/tmp/clients.xml"
OUTPUT_FILE="/Library/Preferences/com.company.locationapps.plist"

# Step 1: Check if the Location Services database exists
if [ ! -f "$LS_DB" ]; then
    echo "Location Services Database not found at $LS_DB"
    exit 1
fi

# Step 2: Convert the binary plist to an XML format
# This is necessary because the original plist is in a binary format, which is not human-readable and cannot be easily parsed.
# Converting it to XML allows us to extract and manipulate the data more effectively.
plutil -convert xml1 -o "$XML_DB" "$LS_DB"

# Step 3: Initialize an empty array to store the names of authorized apps
authorized_apps=()

# Step 4: Filter out non-UTF-8 characters and parse authorized apps
while IFS= read -r bundle_id; do
    echo "Processing bundle ID: $bundle_id"
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
            echo "Found app: $app_name ($bundle_id)"
            authorized_apps+=("$app_name ($bundle_id)")
        else
            echo "Found app path but no display name for $bundle_id"
            authorized_apps+=("$bundle_id (No app display name found)")
        fi
    else
        echo "No app path found for $bundle_id"
        authorized_apps+=("$bundle_id (No app display name found)")
    fi

done < <(
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
    '
)

# Step 5: Debugging - Check if the output file exists before creating a new one
# This step ensures we're aware if an existing plist file is already present. This can help in troubleshooting or verifying that the script is running as expected.
if ls -l "$OUTPUT_FILE"; then
    echo "DEBUG: File is visible to the script."
else
    echo "DEBUG: File is NOT visible to the script."
fi

# Step 6: Ensure the output file is freshly created on every run
# Removing the old plist ensures that no outdated or duplicate data remains. This guarantees that the plist only contains the most current information.
if [ -f "$OUTPUT_FILE" ]; then
    echo "Existing plist found. Removing it to create a fresh one."
    rm "$OUTPUT_FILE"
else
    echo "File Doesn't Exist, Will Create: $OUTPUT_FILE"
fi

# Step 7: Create a new plist with the required structure
# We initialize the plist with an 'AuthorizedApps' array to store the list of apps. This structure is required for consistent data formatting.
echo "Creating new plist file at $OUTPUT_FILE"
/usr/libexec/PlistBuddy -c "Add :AuthorizedApps array" "$OUTPUT_FILE"

# Step 8: Set permissions to ensure future detection and access
# Setting appropriate permissions ensures the file is readable and writable by system processes that may need to access or update it.
chmod 644 "$OUTPUT_FILE"
chown root:wheel "$OUTPUT_FILE"

# Confirm permissions to verify that they were set correctly
ls -l "$OUTPUT_FILE"

# Step 9: Populate the plist with the authorized apps
for app in "${authorized_apps[@]}"; do
    echo "Adding to plist: $app"
    /usr/libexec/PlistBuddy -c "Add :AuthorizedApps: string $app" "$OUTPUT_FILE"
done

# Step 10: Final confirmation message
echo "Location Services apps have been written to $OUTPUT_FILE"
