#!/bin/zsh
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Custom Attribute Script to Check if All Apple-provided Software Is Current and up2date
# CIS Benchmark Level 1 - 1.1 Ensure All Apple-provided Software Is Current
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
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
#
# -------------------------------------------------------------------------------------------------------------------------------
# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/
#
# SCRIPT VERSION/HISTORY:
# Original script: 
# 21-12-2024 - Oktay Sari - script version 1.0
#
# ROADMAP/WISHLIST:
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Get the current macOS major version
current_major_version=$(sw_vers -productVersion | cut -d '.' -f 1)
next_major_version=$((current_major_version + 1))
next_next_major_version=$((current_major_version + 2))

# Check for available updates excluding next major macOS versions
software_update_status=$(softwareupdate -l 2>&1 | grep -e Version | grep -v "macOS.*$next_major_version" | grep -v "macOS.*$next_next_major_version" 2>/dev/null)

# Check if the software update server is reachable
update_server_response=$(softwareupdate -l 2>&1 | grep -c "No response from Apple Software Update server.")

# Determine update status
if [[ -z "$software_update_status" && "$update_server_response" -eq 0 ]]; then
    echo "PASSED: There are no Apple Software updates available"
else
    echo "FAILED: There are Apple updates available that need to be installed"
fi

