#!/bin/bash
# -------------------------------------------------------------------------------------------------------------------------------
# Script to extract and identify URL protocols from iOS app .ipa files
# -------------------------------------------------------------------------------------------------------------------------------
#
# This script extracts all URL schemes (CFBundleURLSchemes) from the Info.plist file of an iOS app .ipa file. It outputs:
# 1. A complete list of all CFBundleURLSchemes found.
# 2. The most likely URL protocols based on relaxed filtering rules.
#
# DISCLAIMER:
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to use this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
#
# IMPORTANT:
# The accuracy of identifying URL protocols depends on the filtering rules applied in the script. Always review the complete list of 
# CFBundleURLSchemes output to ensure no critical entries are missed. This script works on extracted Info.plist files and assumes the 
# .ipa file is valid and contains the required structures.
#
# -------------------------------------------------------------------------------------------------------------------------------
# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/
#
# NOTE:
# This script is by no means perfect.
# If you think you have a good idea to further enhance this script, then please reach out.
#
# SCRIPT VERSION/HISTORY:
# 18-01-2025 - Oktay Sari - Initial version for URL scheme extraction
# 19-01-2025 - Oktay Sari - Added clear distinction between full list and most likely protocols
# 22-01-2025 - Oktay Sari - Enhanced filtering logic to include single-dot URL protocols
# 22-01-2025 - Oktay Sari - script version 1.0
#
# ROADMAP/WISHLIST:
# - Further refine filtering rules for edge cases
# - Add support for batch processing of multiple .ipa files
# - Add logging to a file for detailed review
#
# Requirements:
# - A valid .ipa file to analyze
# -------------------------------------------------------------------------------------------------------------------------------

# Check if an argument (file path) is provided
if [ -z "$1" ]; then
    echo "⛔ Please provide the path to the .ipa file."
    exit 1
fi

# Verify the provided file exists
if [ ! -f "$1" ]; then
    echo "⛔ File $1 does not exist."
    exit 1
fi

# Create a unique temporary directory
TEMP_DIR=$(mktemp -d)
IPA_FILE="$1"

# Unzip the IPA file into the temporary directory
echo "Extracting $IPA_FILE..."
unzip -q "$IPA_FILE" -d "$TEMP_DIR" || { echo "⛔ Failed to unzip the file."; rm -rf "$TEMP_DIR"; exit 1; }

# Locate the Info.plist file inside the extracted app bundle
APP_FOLDER=$(find "$TEMP_DIR/Payload" -name "*.app" -type d | head -n 1)
PLIST_FILE="$APP_FOLDER/Info.plist"

if [ ! -f "$PLIST_FILE" ]; then
    echo "⛔ Info.plist not found in the app bundle."
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Extract all CFBundleURLSchemes
echo "URL Schemes found:"
ALL_SCHEMES=$(xmllint --xpath "//key[text()='CFBundleURLSchemes']/following-sibling::array/string/text()" "$PLIST_FILE" 2>/dev/null)

if [ -z "$ALL_SCHEMES" ]; then
    echo "⛔ No URL schemes found."
    rm -rf "$TEMP_DIR"
    exit 0
fi

# Print all URL schemes as is
echo "------------"
echo "These are all the CFBundleURLSchemes values in the info.plist file:"
echo "$ALL_SCHEMES" | tr ' ' '\n'

# Separator line
echo "------------"
echo "These are most likely the URL protocols you look for:"

# Filter and print likely URL protocols
LIKELY_SCHEMES=$(echo "$ALL_SCHEMES" | tr ' ' '\n' | grep -E '^([a-zA-Z0-9\.\-]+)$' | grep -E '^[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]+)?$')

if [ -z "$LIKELY_SCHEMES" ]; then
    echo "⚠️ No clear URL protocols identified. Please review the full list above for potential candidates."
else
    echo "$LIKELY_SCHEMES"
    echo "------------"
    echo "✅ Note: Review the full list above to ensure no important URL protocols are missed."
fi

# Cleanup the temporary directory
rm -rf "$TEMP_DIR"
