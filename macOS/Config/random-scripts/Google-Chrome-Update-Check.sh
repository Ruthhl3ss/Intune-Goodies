#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# remove the previous line (set -x) if you want to run the script line by line.
# in terminal type: bash -x scriptname

# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
# -------------------------------------------------------------------------------------------------------------------------------
# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/

# NOTE:
# I've used this script for testing and learning. 
# Installed enterprise version: https://chromeenterprise.google/intl/en_us/browser/download/#mac-tab
# This script is by no means perfect. I'm also not an expert bash programmer. 
# If you think you have a good idea to further enhance this script, then please reach out.

# SCRIPT VERSION/HISTORY:
# 15-11-2023 - Oktay Sari - script version 1.0

# ROADMAP/WISHLIST:
# 1:

# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
# Path to Google Chrome
chromeAppPath="/Applications/Google Chrome.app"
# Log file path
logFile="/var/log/forceChromeUpdate.log"

# Function to write to log
log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a "$logFile"
}

# Function to get the currently installed version of Google Chrome
getInstalledChromeVersion() {
    if [ -d "$chromeAppPath" ]; then
        local version=$(defaults read "$chromeAppPath/Contents/Info" CFBundleShortVersionString)
        echo $version
    else
        echo "Not Installed"
    fi
}

# Function to force an update check
forceChromeUpdateCheck() {
    local keystoneAgent="/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/MacOS/ksadmin"
    if [ -f "$keystoneAgent" ]; then
        log "Triggering Google Chrome update check..."
        if "$keystoneAgent" -productID "com.google.keystone" -verbose 2>> "$logFile"; then
            log "Update check triggered. If an update is available, it will be downloaded and installed."
        else
            log "Error occurred while trying to trigger update check."
        fi
    else
        log "Google Software Update agent not found. Unable to trigger update check."
    fi
}

# Main script logic
installedVersion=$(getInstalledChromeVersion)

if [ "$installedVersion" != "Not Installed" ]; then
    log "Installed version of Google Chrome: $installedVersion"
    log "Checking for updates..."
    forceChromeUpdateCheck
else
    log "Google Chrome is not installed."
fi
