#!/bin/bash

################################################################################
# Script Name: set_audit_retention.sh
# Description: This script checks and sets the audit_control file for correct retention settings on macOS.
#              It ensures the file exists, copying from an example if necessary, updates retention settings using atomic operations,
#              and manages backups of the audit_control file.
#
# NOTE: This script implements CIS Benchmark recommendation 3.4 Ensure Security Auditing Retention Is setting
# 		THIS SCRIPT DOES NOT ENABLE THE AUDITD SUBSYSTEM. It only handles file creation and setting
#		the required retention according to the CIS Benchmarks
#
# AUTHOR: Oktay Sari
# https://allthingscloud.blog
# https://github.com/oktay-sari/
#
# SCRIPT VERSION/HISTORY:
# 23-02-2025 - Oktay Sari - Script version 1.0 initial script
# 23-02-2025 - Oktay Sari - Script version 1.1 move backup to update function
# 12-02-2025 - Oktay Sari - Script version 1.2 add lock file
# 15-02-2025 - Oktay Sari - Script version 1.3 add readonly variables
# 19-02-2025 - Oktay Sari - Script version 1.4 add enhanced logging
# 22-02-2025 - Oktay Sari - Script version 1.5 add secure backup rotation
# 23-02-2025 - Oktay Sari - Script version 1.6 handle the case where the expire-after line doesn't exist in the audit_control file.
#
# ------------------------------------------------------------------------------
# DISCLAIMER:
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases.
# Users are advised to employ this script at their own discretion and risk.
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
#
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
# ------------------------------------------------------------------------------
# 
#
# Usage: This script must be run as root, preferably via Intune.
#
# Note: This script is intended for macOS systems.
# 		This script is by no means perfect. I'm not an expert bash programmer and learn with every script I write
# 		If you think you have a good idea to further enhance this script, then please reach out.
#
# DEPRECATION NOTICE
#
# The audit(4) subsystem has been deprecated since macOS 11.0, disabled since
# macOS 14.0, and WILL BE REMOVED in a future version of macOS.  Applications
# that require a security event stream should use the EndpointSecurity(7) API
# instead.
#
# On this version of macOS (15), you can re-enable audit(4) by renaming or copying
# /etc/security/audit_control.example to /etc/security/audit_control,
# re-enabling the system/com.apple.auditd service by running `launchctl enable
# system/com.apple.auditd` as root, and rebooting.
################################################################################
#
#
# Script settings, enable strict error handling
set -euo pipefail
IFS=$'\n\t'

# Define all variables and constants first
# We use readonly in shell scripts to declare variables with constant values that cannot be modified or redefined throughout the script's execution, 
# enhancing script security and predictability.
readonly SCRIPT_NAME=$(basename "$0")
readonly AUDIT_CONTROL_PATH="/etc/security/audit_control"
readonly AUDIT_CONTROL_EXAMPLE_PATH="/etc/security/audit_control.example"
readonly LOG_DIR="/Library/Logs/Microsoft/IntuneScripts/audit"
readonly LOG_FILE="${LOG_DIR}/audit_retention_config.log"
readonly DESIRED_RETENTION_SETTING="60d OR 5G"
readonly MAX_BACKUPS=5
readonly LOCK_FILE="/var/run/audit_retention_config.lock"

# Logging configuration - bash 3 compatible
readonly LOG_LEVEL_DEBUG=0
readonly LOG_LEVEL_INFO=1
readonly LOG_LEVEL_WARN=2
readonly LOG_LEVEL_ERROR=3
readonly LOG_LEVEL=$LOG_LEVEL_INFO

# Set restrictive umask. The command umask 027 is used in the script to set restrictive default permissions, 
# ensuring that newly created files are only writable by the owner, and readable and executable by the owner and group, 
# while others have no permissions.
umask 027

# Function Definitions
log() {
    local level=$1
    shift
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Convert text level to numeric
    local numeric_level
    case $level in
        "DEBUG") numeric_level=$LOG_LEVEL_DEBUG ;;
        "INFO")  numeric_level=$LOG_LEVEL_INFO ;;
        "WARN")  numeric_level=$LOG_LEVEL_WARN ;;
        "ERROR") numeric_level=$LOG_LEVEL_ERROR ;;
        *)       numeric_level=$LOG_LEVEL_ERROR ;;
    esac
    
    if [[ $numeric_level -ge $LOG_LEVEL ]]; then
        echo "${timestamp} - ${level} - $*" | tee -a "$LOG_FILE"
    fi
}

# File locking functions. Her we attempt to create a directory as a lock mechanism and retry for up to 30 seconds if unsuccessful, 
# logging an error and exiting if it fails. The release_lock() removes this directory to release the lock, ensuring the script runs exclusively at any given time.
acquire_lock() {
    local timeout=30
    local attempts=0
    
    while ! mkdir "$LOCK_FILE" 2>/dev/null; do
        attempts=$((attempts + 1))
        if [[ $attempts -ge $timeout ]]; then
            log "ERROR" "Failed to acquire lock after ${timeout} seconds"
            exit 1
        fi
        sleep 1
    done
}

release_lock() {
    rm -rf "$LOCK_FILE"
}

# The cleanup function is a best practice in scripting, ensuring that the script cleans up 
# all its temporary files and resources, even if it exits unexpectedly
cleanup() {
    local exit_code=$?
    if [[ -n "${temp_file:-}" ]]; then
        rm -f "$temp_file"
    fi
    release_lock
    exit $exit_code
}

# Verify root privileges. When deployed with Intune, it should run as root by default. 
check_root() {
    if [[ $(id -u) -ne 0 ]]; then
        log "ERROR" "This script must be run as root"
        exit 1
    fi
}

# Validate directory and file paths
validate_paths() {
    local dir
    for path in "$LOG_DIR" "$(dirname "$AUDIT_CONTROL_PATH")"; do
        dir=$(dirname "$path")
        if [[ ! -d "$dir" ]]; then
            log "ERROR" "Parent directory does not exist: $dir"
            exit 1
        fi
    done
}

# Create log directory with secure permissions
setup_logging() {
    if [[ ! -d "$LOG_DIR" ]]; then
        mkdir -p "$LOG_DIR"
        chmod 755 "$LOG_DIR"
        chown root:wheel "$LOG_DIR"
    fi
    
    # Rotate logs if they exceed 10MB
    if [[ -f "$LOG_FILE" && $(stat -f%z "$LOG_FILE") -gt 10485760 ]]; then
        mv "$LOG_FILE" "${LOG_FILE}.1"
        gzip "${LOG_FILE}.1"
    fi
}

validate_retention_setting() {
 local setting=$1
    # Matches pattern like "60d OR 5G" with flexible spacing
    if ! [[ $setting =~ ^[0-9]+d[[:space:]]+OR[[:space:]]+[0-9]+G$ ]]; then
        log "ERROR" "Invalid retention setting format: $setting"
        exit 1
    fi
}

# ----------------------------------------------------------------------------------------
# START - Function to create the audit_control file.
# ----------------------------------------------------------------------------------------
# NOTE: This section will make sure we have a good audit_control file to start with.
#		The script will exit if the audit_control.example file cannot be found.
#		This could indicate that Apple has removed auditd completely from the OS
manage_audit_control() {
    log "INFO" "Managing audit_control file"
    if [[ ! -f "$AUDIT_CONTROL_PATH" ]]; then
        if [[ ! -f "$AUDIT_CONTROL_EXAMPLE_PATH" ]]; then
            log "ERROR" "Example audit_control file not found"
            exit 1
        fi
        
        if ! cp -p "$AUDIT_CONTROL_EXAMPLE_PATH" "$AUDIT_CONTROL_PATH"; then
            log "ERROR" "Failed to create audit_control file"
            exit 1
        fi
    fi

	# Set secure permissions
    chmod 400 "$AUDIT_CONTROL_PATH"
    chown root:wheel "$AUDIT_CONTROL_PATH"
    
    # Verify permissions
    local perms
    perms=$(stat -f '%Sp' "$AUDIT_CONTROL_PATH")
    if [[ "$perms" != "-r--------" ]]; then
        log "ERROR" "Failed to set correct permissions on audit_control"
        exit 1
    fi
}
# ----------------------------------------------------------------------------------------
# END - Function to create the audit_control file.
# ----------------------------------------------------------------------------------------
#
#
# ----------------------------------------------------------------------------------------
# START - Update audit retention with atomic operation
# ----------------------------------------------------------------------------------------
update_audit_retention() {
    local current_setting=""
	validate_retention_setting "$DESIRED_RETENTION_SETTING"

	# Check if expire-after line exists
	if grep -q '^expire-after:' "$AUDIT_CONTROL_PATH"; then
    	# Extract the current retention setting from the file, cleaning up whitespace around it
    	current_setting=$(grep '^expire-after:' "$AUDIT_CONTROL_PATH" | sed 's/^expire-after://' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
	else
   		log "INFO" "No expire-after setting found in audit_control, will add it"
	fi
    
    if [[ "$current_setting" != "$DESIRED_RETENTION_SETTING" ]]; then
        log "INFO" "Updating retention from '${current_setting}' to '${DESIRED_RETENTION_SETTING}'"
        
        # Create a backup before making changes
        local backup_path="${AUDIT_CONTROL_PATH}.bak_$(date '+%Y%m%d_%H%M%S')"
        if ! cp -p "$AUDIT_CONTROL_PATH" "$backup_path"; then
            log "ERROR" "Failed to create backup"
            exit 1
        fi
        
        # Verify backup integrity
        if ! cmp -s "$AUDIT_CONTROL_PATH" "$backup_path"; then
            log "ERROR" "Backup verification failed"
            exit 1
        fi

        # Use a temporary file to safely prepare changes before applying them to the audit_control file
        local temp_file=$(mktemp)
        
    # handle the case where the expire-after line doesn't exist in the audit_control file.    
    if [[ -z "$current_setting" ]]; then
    	# Line doesn't exist, append it to the file
    	if ! cp "$AUDIT_CONTROL_PATH" "$temp_file"; then
        	rm -f "$temp_file"
        	log "ERROR" "Failed to copy audit_control file"
        	exit 1
    	fi
    	if ! echo "expire-after:${DESIRED_RETENTION_SETTING}" >> "$temp_file"; then
        	rm -f "$temp_file"
        	log "ERROR" "Failed to add retention setting"
        	exit 1
    	fi
	else
    	# Line exists, update it
    	if ! sed "s/^expire-after:.*$/expire-after:${DESIRED_RETENTION_SETTING}/" "$AUDIT_CONTROL_PATH" > "$temp_file"; then
        	rm -f "$temp_file"
        	log "ERROR" "Failed to update retention setting"
        	exit 1
    	fi
	fi
        
        # Replace the original file with the updated temporary file
        if ! mv "$temp_file" "$AUDIT_CONTROL_PATH"; then
            rm -f "$temp_file"
            log "ERROR" "Failed to replace audit_control file"
            exit 1
        fi

        chmod 400 "$AUDIT_CONTROL_PATH"
        chown root:wheel "$AUDIT_CONTROL_PATH"
        log "INFO" "Retention setting updated successfully with atomic operations."

        # Secure backup rotation. Perform secure backup rotation by locating all backup files named audit_control.bak_* in the directory
        # If rotation errors out, it will log the Error
    	find "$(dirname "$AUDIT_CONTROL_PATH")" -name "audit_control.bak_*" -type f -exec stat -f "%m %N" {} \; |
    		sort -nr |
    		tail -n +$(($MAX_BACKUPS + 1)) |
    		cut -d' ' -f2- |
    		while IFS= read -r file; do
        		rm -f "$file" || { log "ERROR" "Failed to delete old backup $file"; continue; }
    		done
    else
        log "INFO" "Retention setting already correct"
    fi
}
# ----------------------------------------------------------------------------------------
# END - Update audit retention with atomic operation
# ----------------------------------------------------------------------------------------
# 
# Set up trap handlers after all functions are defined
# Enhanced error trap with context. When an error is triggered, it logs the error with specific details—including the script name, 
# the line number where the error occurred, the command that caused the error, and its exit code
trap 'last_error=$?; log "ERROR" "Error in ${SCRIPT_NAME} at line $LINENO executing: $BASH_COMMAND (exit code: $last_error)"; exit $last_error' ERR
trap cleanup EXIT
trap 'exit $?' TERM INT

# Main execution
main() {
    check_root
    validate_paths
    setup_logging
    
    log "INFO" "Starting audit configuration"
    
    acquire_lock
    manage_audit_control
    update_audit_retention
    
    log "INFO" "Script completed successfully"
}

main
exit 0