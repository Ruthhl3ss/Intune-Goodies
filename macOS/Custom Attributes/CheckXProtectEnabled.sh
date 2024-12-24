#!/bin/zsh
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Custom Attribute Script to Check if X-Protect services are running
# CIS Benchmark Level 1 - 5.10 Ensure X-Protect Is Running and Updated
# -------------------------------------------------------------------------------------------------------------------------------
#
# remove the previous line (set -x) if you want to run the script line by line.
# in terminal type: bash -x scriptname
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
# NOTE:
# This script is by no means perfect. I'm also not an expert bash programmer. 
# If you think you have a good idea to further enhance this script, then please reach out.
# Some organizations may have Mac OS anti-malware tools that XProtect conflicts with.
# If X-protect is disabled, the system might be compromised and needs to be investigated.
#
# SCRIPT VERSION/HISTORY:
# Original script: 
# 20-12-2024 - Oktay Sari - script version 1.0
#
# ROADMAP/WISHLIST:
#
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------

# Check if XProtect services are running
xprotectenable=$(/bin/launchctl list | /usr/bin/grep -cE "(com.apple.XprotectFramework.PluginService$|com.apple.XProtect.daemon.scan$)")

# Get the major macOS version
macOSversion=$(/usr/bin/sw_vers -productVersion | cut -d '.' -f 1-2 | awk -F '.' '{print $1}')

# Check XProtect launch and background scan statuses
xprotectlaunch=$(/usr/bin/xprotect status | /usr/bin/grep -c "XProtect launch scans: enabled")
xprotectbackground=$(/usr/bin/xprotect status | /usr/bin/grep -c "XProtect background scans: enabled")

# Determine XProtect status
if [[ $macOSversion -ge 15 && $xprotectlaunch -eq 1 && $xprotectbackground -eq 1 ]] || [[ $xprotectenable -eq 2 ]]; then
    echo "PASSED: XProtect is enabled"
else
    echo "FAILED: XProtect is disabled and needs to be investigated"
fi
