#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
#
# Script to configure Hide IP Address in Safari
#
# -------------------------------------------------------------------------------------------------------------------------------
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
# 17-02-2025 - Oktay Sari - Script version 1.0
#
# ROADMAP/WISHLIST:
# - 
#
# Requirements:
# - MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables

appname="SafariIPHiding"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"

# Define the setting values
DISABLED=66976992        # Hide IP address disabled
TRACKERS_ONLY=66976996   # Hide IP address from trackers only
TRACKERS_WEBSITES=66977004 # Hide IP address from trackers and websites

# Set your desired configuration here
SETTING_VALUE=$TRACKERS_WEBSITES

# Function for formatted logging
function write_log() {
    local log_type=$1
    local message=$2
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$timestamp | $log_type | $message" | tee -a "$log"
}

# Function for error logging and exit
function error_exit() {
    write_log "ERROR" "$1"
    write_log "ERROR" "Script terminated with error"
    write_log "INFO" "=============================================================="
    exit 1
}

# Function to check Full Disk Access
function check_fda() {
    # Create a test file in a protected directory
    local test_file="/Library/Application Support/com.apple.TCC/FDA_test_$(date +%s)"
    
    if ! touch "$test_file" 2>/dev/null; then
        write_log "ERROR" "Full Disk Access check failed - Unable to create test file"
        write_log "ERROR" "Please grant Full Disk Access to Terminal/script runner in System Settings > Privacy & Security > Full Disk Access"
        return 1
    fi
    
    # Clean up test file
    rm "$test_file" 2>/dev/null
    
    # Additional FDA validation by attempting to read a random user's Safari preferences
    local test_user=$(dscl . list /Users | grep -v "^_" | grep -v "daemon" | grep -v "nobody" | head -n 1)
    if [ -n "$test_user" ]; then
        if ! ls "/Users/$test_user/Library/Containers/com.apple.Safari" >/dev/null 2>&1; then
            write_log "ERROR" "Full Disk Access check failed - Unable to access Safari preferences"
            write_log "ERROR" "Please grant Full Disk Access to Terminal/script runner in System Settings > Privacy & Security > Full Disk Access"
            return 1
        fi
    fi
    
    write_log "INFO" "Full Disk Access check passed"
    return 0
}

# Function to get setting description
function get_setting_description() {
    local value=$1
    case $value in
        $DISABLED)
            echo "Disabled"
            ;;
        $TRACKERS_ONLY)
            echo "Trackers Only"
            ;;
        $TRACKERS_WEBSITES)
            echo "Trackers and Websites"
            ;;
        *)
            echo "Unknown ($value)"
            ;;
    esac
}

# Create log directory with error handling
if [ -d "$logandmetadir" ]; then
    write_log "INFO" "Log directory already exists - $logandmetadir"
else
    write_log "INFO" "Creating log directory - $logandmetadir"
    mkdir -p "$logandmetadir" || error_exit "Failed to create log directory"
fi

# Begin Script Body
write_log "INFO" "=============================================================="
write_log "INFO" "Starting $appname"
write_log "INFO" "Target Setting: $(get_setting_description $SETTING_VALUE)"
write_log "INFO" "=============================================================="

# Check for Full Disk Access before proceeding
if ! check_fda; then
    error_exit "Script requires Full Disk Access to function properly"
fi

# Get all user directories
user_list=$(dscl . list /Users | grep -v "^_" | grep -v "daemon" | grep -v "nobody")

# Loop through each user
for username in $user_list; do
    # Skip system directories
    if [ ! -d "/Users/$username" ]; then
        continue
    fi

    write_log "INFO" "Processing user: $username"
    
    # Set Safari preference path
    PREF_PATH="/Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari"

    # Check current setting
    current_setting=$(sudo -u "$username" defaults read "$PREF_PATH" WBSPrivacyProxyAvailabilityTraffic 2>/dev/null)
    
    if [ "$current_setting" == "$SETTING_VALUE" ]; then
        write_log "INFO" "Setting already configured correctly for user $username ($(get_setting_description $current_setting))"
        continue
    fi

    # Update the setting only if it's different
    write_log "INFO" "Changing setting for $username from $(get_setting_description $current_setting) to $(get_setting_description $SETTING_VALUE)"
    
    if ! sudo -u "$username" defaults write "$PREF_PATH" WBSPrivacyProxyAvailabilityTraffic -int $SETTING_VALUE; then
        write_log "ERROR" "Failed to update Safari settings for user $username"
        continue
    fi
    
    # Verify the setting
    new_setting=$(sudo -u "$username" defaults read "$PREF_PATH" WBSPrivacyProxyAvailabilityTraffic 2>/dev/null)
    
    if [ "$new_setting" == "$SETTING_VALUE" ]; then
        write_log "SUCCESS" "Successfully updated Safari IP hiding setting for user $username"
    else
        write_log "WARNING" "Setting verification failed for user $username"
    fi
done

write_log "INFO" "=============================================================="
write_log "SUCCESS" "Script completed successfully"
write_log "INFO" "=============================================================="

exit 0