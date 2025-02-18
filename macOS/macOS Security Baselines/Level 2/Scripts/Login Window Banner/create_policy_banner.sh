#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
#
# This script implements CIS Benchmark recommendation 5.8 for macOS, which requires a login window warning banner to be displayed to users before they log in.
#
# -------------------------------------------------------------------------------------------------------------------------------
#
# DISCLAIMER:
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases.
# Users are advised to employ this script at their own discretion and risk.
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
# -------------------------------------------------------------------------------------------------------------------------------
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
# -------------------------------------------------------------------------------------------------------------------------------
# AUTHOR: Oktay Sari
# https://allthingscloud.blog
# https://github.com/oktay-sari/
#
# NOTE:
# This script is by no means perfect. I'm not an expert bash programmer.
# If you think you have a good idea to further enhance this script, then please reach out.
# The script always overwrites the PolicyBanner.txt file on each run.
#
# SCRIPT VERSION/HISTORY:
# 17-02-2025 - Oktay Sari - Script version 1.0
#
# ROADMAP/WISHLIST:
# -
#
# Requirements:
# - 
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
appname="CreatePolicyBanner"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"
BANNER_FILE="/Library/Security/PolicyBanner.txt"
SECURITY_DIR="/Library/Security"

# Define the warning message
WARNING_MESSAGE="WARNING: This system is for authorized use only.
By using this system, you agree to be bound by all policies and regulations.
Unauthorized access or use of this system is strictly prohibited and may result in disciplinary action, civil, and/or criminal penalties.
All activities on this system are logged and monitored."

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
    exit 1
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
write_log "INFO" "=============================================================="

# Check if Security directory exists - error if it doesn't
if [ ! -d "$SECURITY_DIR" ]; then
    error_exit "Security directory does not exist. Please ensure /Library/Security is present before running this script"
fi

# Always update the banner file
write_log "INFO" "Updating banner file with current warning message"

# Create/Update the file and add the warning message
if ! echo "$WARNING_MESSAGE" > "$BANNER_FILE"; then
    error_exit "Failed to update banner file"
fi

# Set appropriate permissions
if ! chmod 644 "$BANNER_FILE"; then
    error_exit "Failed to set permissions on banner file"
fi

if ! chown root:wheel "$BANNER_FILE"; then
    error_exit "Failed to set ownership on banner file"
fi

write_log "SUCCESS" "Banner file updated successfully with proper permissions"

# Verify file exists and has correct permissions
if [ -f "$BANNER_FILE" ]; then
    write_log "INFO" "Verifying banner file permissions"
    permissions=$(ls -l "$BANNER_FILE")
    write_log "INFO" "Current permissions: $permissions"
    
    if [[ "$(stat -f %Op $BANNER_FILE)" == "644" && "$(stat -f %Su:%Sg $BANNER_FILE)" == "root:wheel" ]]; then
        write_log "SUCCESS" "Banner file permissions are correct"
    else
        write_log "WARNING" "Banner file permissions are incorrect"
    fi
else
    error_exit "Banner file verification failed - file not found"
fi

write_log "INFO" "=============================================================="
write_log "SUCCESS" "Script completed successfully"
write_log "INFO" "=============================================================="

exit 0